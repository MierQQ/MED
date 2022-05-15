package nsu.mier.backend.controllers;

import nsu.mier.backend.DTOs.*;
import nsu.mier.backend.servises.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping( "/api/v1/query")
public class QueryController {
    private final MedStaffService medStaffService;
    private final StaffService staffService;
    private final PatientRecordsService patientRecordsService;
    private final HospitalRoomService hospitalRoomService;
    private final CabinetsService cabinetsService;

    @Autowired
    public QueryController(MedStaffService medStaffService,
                           StaffService staffService,
                           PatientRecordsService patientRecordsService,
                           HospitalRoomService hospitalRoomService,
                           CabinetsService cabinetsService) {
        this.medStaffService = medStaffService;
        this.staffService = staffService;
        this.patientRecordsService = patientRecordsService;
        this.hospitalRoomService = hospitalRoomService;
        this.cabinetsService = cabinetsService;
    }


    @GetMapping("/1")
    public List<StaffQueryDTO> find1(@RequestParam(required = false, defaultValue = "{}") String institutionIds,
                                     @RequestParam(required = false, defaultValue = "{}") String specializations) {
        return medStaffService.findQuery1(institutionIds, specializations);
    }

    @GetMapping("/2")
    public List<StaffQueryDTO> find2(@RequestParam(required = false, defaultValue = "{}") String institutionIds,
                                 @RequestParam(required = false, defaultValue = "{}") String specializations) {
        return staffService.findQuery2(institutionIds, specializations);
    }

    @GetMapping("/3")
    public List<StaffQueryDTO> find3(@RequestParam(required = false, defaultValue = "{}") String institutionIds,
                                 @RequestParam(required = false, defaultValue = "{}") String specializations,
                                 @RequestParam(required = false, defaultValue = "0") Integer surgeriesNumber) {
        return medStaffService.findQuery3(institutionIds, specializations, surgeriesNumber);
    }

    @GetMapping("/4")
    public List<StaffQueryDTO> find4(@RequestParam(required = false, defaultValue = "{}") String institutionIds,
                                     @RequestParam(required = false, defaultValue = "{}") String specializations,
                                     @RequestParam(required = false, defaultValue = "0") Integer standing) {
        return medStaffService.findQuery4(institutionIds, specializations, standing);
    }

    @GetMapping("/5")
    public List<StaffQueryDTO> find5(@RequestParam(required = false, defaultValue = "{}") String institutionIds,
                                     @RequestParam(required = false, defaultValue = "{}") String specializations) {
        return medStaffService.findQuery5(institutionIds, specializations);
    }

    @GetMapping("/6")
    public List<PatientQuery6DTO> find6(@RequestParam(required = false, defaultValue = "{}") String hospitalIds,
                                        @RequestParam(required = false, defaultValue = "{}") String departmentIds,
                                        @RequestParam(required = false, defaultValue = "{}") String hospitalRoomIds) {
        return patientRecordsService.findQuery6(hospitalIds, departmentIds, hospitalRoomIds);
    }

    @GetMapping("/7")
    public List<PatientNameDTO> find7(@RequestParam(required = false, defaultValue = "{}") String institutionIds,
                                      @RequestParam(required = false, defaultValue = "{}") String medStaffIds,
                                      @RequestParam(required = false) String startDate,
                                      @RequestParam(required = false) String endDate) {
        return patientRecordsService.findQuery7(institutionIds, medStaffIds, startDate, endDate);
    }

    @GetMapping("/8")
    public List<PatientNameDTO> find8(@RequestParam(required = false, defaultValue = "{}") String specializations,
                                      @RequestParam(required = false, defaultValue = "{}") String institutionIds) {
        return patientRecordsService.findQuery8(specializations, institutionIds);
    }

    @GetMapping("/9/1")
    public List<CountDTO> find91() {
        return hospitalRoomService.findQuery91();
    }

    @GetMapping("/9/2")
    public List<CountDTO> find92() {
        return hospitalRoomService.findQuery92();
    }

    @GetMapping("/9/3")
    public List<DepartmentCountDTO> find93() {
        return hospitalRoomService.findQuery93();
    }

    @GetMapping("/9/4")
    public List<DepartmentCountDTO> find94() {
        return hospitalRoomService.findQuery94();
    }

    @GetMapping("/9/5")
    public List<DepartmentCountDTO> find95() {
        return hospitalRoomService.findQuery95();
    }

    @GetMapping("/9/6")
    public List<DepartmentCountDTO> find96() {
        return hospitalRoomService.findQuery96();
    }

    @GetMapping("/10/1")
    public List<CountDTO> find101(@RequestParam(required = false, defaultValue = "{}") String institutionIds) {
        return cabinetsService.findQuery101(institutionIds);
    }

    @GetMapping("/10/2")
    public List<CabinetCountDTO> find102(@RequestParam(required = false) String startDate,
                                        @RequestParam(required = false) String endDate) {
        return cabinetsService.findQuery102(startDate, endDate);
    }

    @GetMapping("/11")
    public List<StaffProductivityDTO> find11(@RequestParam(required = false) String startDate,
                                             @RequestParam(required = false) String endDate,
                                             @RequestParam(required = false, defaultValue = "{}") String doctorIds,
                                             @RequestParam(required = false, defaultValue = "{}") String specializations,
                                             @RequestParam(required = false, defaultValue = "{}") String polyclinicIds) {
        return staffService.findQuery11(startDate, endDate, doctorIds, specializations, polyclinicIds);
    }

    @GetMapping("/12")
    public List<StaffProductivityDTO> find12(@RequestParam(required = false, defaultValue = "{}") String doctorIds,
                                             @RequestParam(required = false, defaultValue = "{}") String specializations,
                                             @RequestParam(required = false, defaultValue = "{}") String hospitalIds) {
        return staffService.findQuery12(doctorIds, specializations, hospitalIds);
    }

    @GetMapping("/13")
    public List<PatientNameDTO> find13(@RequestParam(required = false) String startDate,
                                             @RequestParam(required = false) String endDate,
                                             @RequestParam(required = false, defaultValue = "{}") String doctorIds,
                                             @RequestParam(required = false, defaultValue = "{}") String medIds) {
        return patientRecordsService.findQuery13(startDate, endDate, doctorIds, medIds);
    }

    @GetMapping("/14")
    public List<LabProductivityDTO> find14(@RequestParam(required = false) String startDate,
                                       @RequestParam(required = false) String endDate,
                                       @RequestParam(required = false, defaultValue = "{}") String medIds) {
        return patientRecordsService.findQuery14(startDate, endDate, medIds);
    }
}
