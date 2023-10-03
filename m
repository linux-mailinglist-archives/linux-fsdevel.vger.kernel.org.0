Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02957B66E7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 12:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239762AbjJCK5m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 06:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjJCK5l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:57:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E306AD;
        Tue,  3 Oct 2023 03:57:37 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3930iJW1027534;
        Tue, 3 Oct 2023 10:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zgtAEGOpiZ2HrYckbJMQ1nGWpOJC+qBHOHsTQUX0dy0=;
 b=DJ4gxUUTxP/kWd1A8sAwmLlJhqde524AZtTrZt+ximfAqA9ognRVHpyflgz7gTe34bww
 5oc3FzgCHOIUuVlv+UOhuDRy9ZN3DMkmID03Alak8P6dqxhTccM9fIVOhmH5Fyp+tHEH
 Kz/yuQ10eS6TkdMN4d0rq7xj3X8r+pKh5ai1nqQpKV+oou/1L0kFf4/NZikfy2sirSaT
 +Aou7TccWpxvKdCy/gvhoWBYjjUvOKDLvTnFjg46zxFHDRLXJxMPjpoFeYpdSx11TtUV
 6bjFD2bYhszw9vXwFucfCExNW4SRbj8ComDoAyWfVkrdQ9Yj7lUyM/XfrqirZb8X32Rc bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tec7vcbqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 10:57:03 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 393ALoBp000499;
        Tue, 3 Oct 2023 10:57:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea45rvy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 10:57:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzHUhjZ8oKuR28RhqilpEDUoWjLKS36lLwPuR9ScCCv2YUkp7YQNWEK5yAqG+E0eWj00+bPvFUhX+b4sWrp8ajTms2gJK9svyViD9tVmCHHAZN7hQz1EzO/c4CoKiCqg1oOfeE1yVJfmQj3x4S5tNM7oVIUphBlOtO3A8BbZ8iRmeBiU0TANT2OFoMAvdVAhm56WH3JYJSlIyAaB83XufU3X0nkppWoG/A//HJTsn4m5+pDRVLYnz3Tiz/iydRDvi+KMcWxRjuDuibM7TjAxo9cdl0BIVp8fpizt51sY2nkKCTh/A8Bk32I9H2FKpSEhCSrJ08fxXXjDRi89Oi++Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgtAEGOpiZ2HrYckbJMQ1nGWpOJC+qBHOHsTQUX0dy0=;
 b=iHamrU6x5uHuogxp8b2caoZJXDyGIwJ+3Oqfw6IDgN+MZ6blPw+WnKuDiTKlW6XQzDTr24hoqzpNwWLMcayNwVykSqYFzCW+DT4ckSGJx8QTLd9QGvXF8+fAO62L/5VCavwpoC/uILtluvitsaJSSSSzqmg2SXc4bWyA/OmQkD1ZR0HDWvBWKEwwKIyDaeMAVjmnkLKa+drKT7Cq6WS7RM+F4Y9lC3Suzi9cSMKO1zYcmt67Abr8iwXtdvY4kipeQr7ahtAl2S9IwbcfwgBEz7zWVWs4yo4A7OcJ4BYuSjJTCunWKleNbGzceKo+EYsfsilrb3p95A7WPksqGO9MoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgtAEGOpiZ2HrYckbJMQ1nGWpOJC+qBHOHsTQUX0dy0=;
 b=cijGyvqzXt6wBsfdV1Q/kpIm/5L/9ufrkRX2/Hx3mdMYJ1DR0zfo8BqvnZEzjI09GM4rWWyg3GulgcMLlC64Xi/MZaL13s5QYoV9F3eHgDcODzo9MUgbNSCq/na4gjb6S1VqxyhmGtkjAQilXiF6JsjVxoHbLRUmJVRQdpPAhjo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4687.namprd10.prod.outlook.com (2603:10b6:a03:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 3 Oct
 2023 10:57:00 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 10:56:59 +0000
Message-ID: <9be14161-907e-92f6-d214-11df00693fac@oracle.com>
Date:   Tue, 3 Oct 2023 11:56:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 15/21] fs: xfs: Support atomic write for statx
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-16-john.g.garry@oracle.com>
 <ZRuLQKKPCzyUZtC9@dread.disaster.area>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZRuLQKKPCzyUZtC9@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0210.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4687:EE_
X-MS-Office365-Filtering-Correlation-Id: da8f5de0-3c76-4874-16d4-08dbc3ff77c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3oMWcFqBZ/9338QcP8+5Wd1hAAHizgECyDA9sE9wh+G9Ch/kEDCeuBr5zx2rulSd2FMF1npDDo4pMhBSP7a0lSccO0dhLaU75cywQyiAkkbA/1niIdVOMhiLTXTaiTFUGFcZhCRdPp+gUf0EWc+TJZ5xs6+ZYpIxG9QlkMybVFw2rvpaqY9s/T3b5cQ9h4jx2pD8BzOxQH+VLFLz/ZJpvnceOqTHBb/nc0uZIq4pGSi8i8J2DW/ddBv/ICi1C9e/sRIaCbaqafwv1gJMF0BGetujZZbrzwTqeGNlRNabBMsC7Cy+/6cfCra2jBuWS1mZRYly6dZhxCtEt+Y+n0eeXGI58pbArHYPqVK9yjToAnlsrGZlCrXL8javqC55TN7wDmlPIDtbZ4lu1ZMHHyTNvE7RyH/B+6r1qvauS4rCXKBjiiFmaAgXjxiVWQILUla6q8O+5HCGIGJgNhEC3/G89D8XXcJZOdm+2txyOGOacZ9m6khnYzXLmW2N+knym4kgjdOfFzNlkAfOcjEzS2GJxZwLlfNntdTicfUrn/JhX2Z1T69MJuYFGIvjgadBJC1W0764xnyRmX2nzHxrK+6SmVClpjlLYXV8oRmtjdLwZJZsmKmh2CiQ11dVji34ihWlSGbEtx3jLrpGF57mbwJcag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(4326008)(83380400001)(8936002)(8676002)(6916009)(316002)(478600001)(41300700001)(66946007)(66556008)(66476007)(26005)(6512007)(6506007)(6666004)(2616005)(6486002)(36916002)(53546011)(2906002)(38100700002)(5660300002)(86362001)(31696002)(7416002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDIwZUZzeFEwREhhSTR0aE9meElHTWNYQUFJUFVOZktHN0VXelBNbDIrbWR3?=
 =?utf-8?B?bGxTSnlvZ1FjNU5kNmVhVVR5N0tIa3ZFM3VtZEhNaERsbGRURFJnaFVRa3RB?=
 =?utf-8?B?a2ZCR1o2NWFFUDI5eVE0NWkxM24wWCtHRWUyWFVDQzNBblBiMmRlY3g5Y2l4?=
 =?utf-8?B?S3d0YTVYai9lU3JWVDVCZ2dvNWw4ODNkaEFqZ3YrUW9sdjBnQzJhemdkQnMv?=
 =?utf-8?B?dmwrOXcwdWtMc0N6VTlpMVd3UUhuUUpFNU5paDdta3pFd1JVbUZJOEVMK1Qv?=
 =?utf-8?B?QVBPR3pNa0pJaFRTTkQ0Z1I3NlQyVzM1S2J4WGF3SVgzN29rU3FKWDV1MEI0?=
 =?utf-8?B?MSt5WVRnYk1WR1JJc3lXSDJYT1FUdWs1eERWUzR3VEM2cDEwKzM0TGphNzdD?=
 =?utf-8?B?UzlZVG5LRVB6WGd3NU9RemQydXo4M043dUZKVFRwN2xsQld1Tm52Tk83M3NF?=
 =?utf-8?B?dFNaeWFHNlQvUjlZOXRRaGtIeVZqMEg4cGZyNjl6ckIvSW1KanVwbVZwN0VC?=
 =?utf-8?B?T2t5QUJhdnVDVVZRc3h3eWdtMFRZWHVnSE9IWVkzU0hDQ0ZpVnJRMkJBdHR5?=
 =?utf-8?B?SHk2K2VLay9aZFoyUXhZeFJmcy8ySy9kNDNVa1BuK1I4bGM3QVhVbTBrdFRP?=
 =?utf-8?B?ZFJWVnVkTGhBQ1lpelNVNVF1MTJ1eC90dTNMVjU1czNzbmxlQWdJTTBFM0tX?=
 =?utf-8?B?Nyt6aFhFSktsOUxSbTF4SFVWdWVxTUhhOE5jU3VQVjRnNzhpckFwMVgvOXFj?=
 =?utf-8?B?ZEhhUzFvd1E1cW9ybDQ2V0tIRVFLUXBLOXpuZmw4VU9EYVhhMklQTW1rK2R1?=
 =?utf-8?B?M3lLdjlONVYrb1FpeUpUb1FwUjVRMnZiS0IxekFVdWprSU52OE12VEJEbUZw?=
 =?utf-8?B?RUVUY0RqWGlQTDRSVHVZczRPM25xTmtjdFEwOUJNekNleUJuRmdVN1NWSFFo?=
 =?utf-8?B?M0hrUmRpWWtZWUtiQUtjcnVVZGkxT2hZQUZXbDV6N2tHeTJVTUdiRWpWMjRX?=
 =?utf-8?B?cGllQ0lTTzF0SGlydFBITzBOMHprRUhSeWJmZDNnK1dLUCtBUWhtYmZjSlBP?=
 =?utf-8?B?Y0x0UVRSUzZVTE9TTXRjY3NVREppZU4xMUFtOUVtQnlHTzMrNzdDWG40dDRL?=
 =?utf-8?B?Q3VLOHpMNk1lZU04WVU0R2tVVmRpaktrVXpCbFNZSmc1bXdUYkNRdWVOYTdz?=
 =?utf-8?B?dkp6WlE4QU54bVpPRHFYTkRuYXI1RlBXVFFuS2MxZXZrcXBaalZUTTU5aEFu?=
 =?utf-8?B?ZUhiRVRMZmtTWmNqZjlLMm1TeGNycjV1c2lnb3NTem5uL1l0L2daekFmTWtn?=
 =?utf-8?B?dFlMOHFneDYxVlJFcWtEZFA4djE3eUdDN2Vqd0l0OUlIS0MzL3k2Q0VHR1FY?=
 =?utf-8?B?aDlENDhHNUppa1VkNXRpa3hYblFPQ1NFUXNYcWlWUVhuSjM0Ym51KytVaG1U?=
 =?utf-8?B?cUlVSkp3UEVsNDBuMkpoS3pUVURzQjFtVFdxZ2J4by9YUU9tdzJJL0pTNUpV?=
 =?utf-8?B?S1YyN3VQNVpCOVVvTFF6ZnNOeFJlcktmZ1ltNG8zNW1DVHdJVnE1M3hCNVRM?=
 =?utf-8?B?NWpOYmVreUNzQjRHNzVVQ0NwMUxSd1lTNXg5b1NiVlVqeVcxYmNScnVYVmFG?=
 =?utf-8?B?cnpFNE5LT3ZOZmNLODk2WGJNS094YnQ5cGZYV2lyQjJTQVgyanBHbSs1WHZx?=
 =?utf-8?B?MThvRDlQMXdaeGtTa1QvUzYzanV2WHhvMmJVakFraVBzeEtpcGhORlVrK1BQ?=
 =?utf-8?B?T1JnYTJIL1RkQXUvZ1E2ZkgvMVVwYXNTK05rdkM1eWh0dlZDOVlkR1FwdzVh?=
 =?utf-8?B?MjV6cS95Z0FMMWlFbzZMTjJzeVNFc2N1eDY0SCtUdkJhUHNPaTZabW9KM0lV?=
 =?utf-8?B?SlYxU04yM3ZlVGNwRUluQWc5MDFXUDBaVDlncnFaVU5TZ0RQWm85THVZKzVV?=
 =?utf-8?B?VFpneTBiM3NKWlZzSWtkcWxJY1dLZGNuWUZIT0l1T1Z0ajJXWWZENlU3MGRY?=
 =?utf-8?B?UTQwckk3bXNiaFZBdFFIRFk0WlZvcDV2NXZGY21LUkxBWTc3YjhNMzhEb1E5?=
 =?utf-8?B?Q2dPVDVMTW05K0tpQW1sZUpxQUthVjZZM0ViTEc0SXZYd1NDbTdCTVpyUkxD?=
 =?utf-8?Q?6lsw/3MmQDvi6LyXIR9MRa9fv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VnE0eC93c042cGNrQmR6aU1LZTcvVVphUmkrM0lxZEtCMDhMZi9ZTVYwUUQx?=
 =?utf-8?B?VVl3ekhlai9NS1I2TDFBTmtoZi9zbHh0a3FtKzBkMnoxdXZyRHBPODk4Tmpj?=
 =?utf-8?B?UUsyV2R4WnNHVE8wT3BmNVY4NStvRENIWUVxcUVIUmVmbHJsS25yMkRZN3gw?=
 =?utf-8?B?RlVqVWRRc3FZdlJreUhFOTdsS0pzeG1jL01hY0xZK2drbUpoK1BTaWFCS051?=
 =?utf-8?B?WnFyc3ZkN0dMV2VBUEdlR0xrT2RlMUFxUFZPOU56clAxYmJyVXY0ekZrK1o1?=
 =?utf-8?B?bW1iS2RKQWZaNWY0dmZlNWozUEE2M2thckJ3MVpYUXVtV1RRUVRPcEM4bnQw?=
 =?utf-8?B?S0NiUzE4aTMxNzFEVlNtRVhHM0VWZ0dlWXM4c2ZCdnFGbkZqVWsvbFJBaFlj?=
 =?utf-8?B?cUJHU256NHpzaWRrMTA0L3JPanhhNG5DbERYRlZqUk1oRmRsQ2s4MmFETmVp?=
 =?utf-8?B?RDBHWWNxeUJmSWRkTllWNG9GdExPMHVqVEJjRENPSGRzME5qSE9taXJWSmx1?=
 =?utf-8?B?bEFicWxkK09mK2IvRm00WWVZMU5rbEtJbEs0WlgzeTkxNE8rTElFNlp0NEE3?=
 =?utf-8?B?UnVLelhkcnIrUktpS0Z5dFFYRGJpdjhkSW1GZE5ORnB6cElMOE9xSUpNV1JU?=
 =?utf-8?B?WW1kb2dLVTdxQTZRUFFrYWZFbDFkN1ZoRTJsNmVKSTg1K0RDMUVjQjAvamV1?=
 =?utf-8?B?UnFoSlJ0ams5VVhHUFpYVjc0SUJQakY2ZzZYVHp2eU1vaTBtVW9zby9vbzlF?=
 =?utf-8?B?UEVyc1dDS3N2Y2xqWnZYQlY1ai9jSHRmUFlhM1h1WWkrUU9Laks1QTZsYSth?=
 =?utf-8?B?WFc1K3g4UElyYitRNUozdlVGdzV5a01FZ1l5QVBIR2RubGRUNmpIckxndXRk?=
 =?utf-8?B?SFlOTlJwaDVxMUNTV2hWd2QvNXBpUVYvVjU5aUJZTTJLeEk1d3dpaXFPSmtW?=
 =?utf-8?B?TE9KMkIvcmVEYmhVdnNLTXE0QXlJWnU0ZlczcmIraUxQdzQ4Lzlod3U2MjhJ?=
 =?utf-8?B?MnNldGlPVjZDUHZqZ3NUN3JQa1c4WlZ1TG9QZm1pT0xvWDFCZW9zSjI4MWNE?=
 =?utf-8?B?MHNnVEdiUUZkSDBkaC82alRXbUVFYlljcUI0RnNwSDN2OGZCOFBKMWZoZnFs?=
 =?utf-8?B?QlRUaS8yc0hZaDB5QXdLUWk4YnhMZFlRVTErVktuZXBOVDVINkNtbWEwVVVa?=
 =?utf-8?B?ZjJmSlVRVlZZc1pXNDZIUmhtU0w3bUp1S3pHYkMyL1hKN0NVSHdCUkJ0QUJ4?=
 =?utf-8?B?aHR2OFhrbjRNZzdFTEdvWmlrakFBNHBQajhzV0RXMEhWSU9HMTFZN0QydnFT?=
 =?utf-8?B?NkVDcVRsU2w5M3F4YlhHSWhTZnJUWk5HMHQycFJzVFhnaFNneFVITGxPeEJO?=
 =?utf-8?B?TmR5UTRlajVqUk02M1FGNWpWUlNsaW1ka01oZWJMZTJkeEI5aXNidjA1cmJE?=
 =?utf-8?B?YVhUWlVrMDlSRm9lQW9ub1lJUUpMd1MvenYzTitRNzBXdlR0TEVNVVk0MXhp?=
 =?utf-8?Q?bsUeXafXlF8uX4iK7cbdkS4lzut?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8f5de0-3c76-4874-16d4-08dbc3ff77c2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 10:56:59.8694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BwjI6WkQUeAzeApMqcr3gX3ms7lKlBS0oY902rjved9kbPK5Fx1TpcrkuDIzlWSVH9pKPWEm5MszXr0DAOqJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_08,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030077
X-Proofpoint-ORIG-GUID: 4eZ0KeBdV-cM8dk56dP9sRJJCclrXq20
X-Proofpoint-GUID: 4eZ0KeBdV-cM8dk56dP9sRJJCclrXq20
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/10/2023 04:32, Dave Chinner wrote:
> On Fri, Sep 29, 2023 at 10:27:20AM +0000, John Garry wrote:
>> Support providing info on atomic write unit min and max for an inode.
>>
>> For simplicity, currently we limit the min at the FS block size, but a
>> lower limit could be supported in future.
>>
>> The atomic write unit min and max is limited by the guaranteed extent
>> alignment for the inode.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/xfs_iops.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++
>>   fs/xfs/xfs_iops.h |  4 ++++
>>   2 files changed, 55 insertions(+)
>>
>> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
>> index 1c1e6171209d..5bff80748223 100644
>> --- a/fs/xfs/xfs_iops.c
>> +++ b/fs/xfs/xfs_iops.c
>> @@ -546,6 +546,46 @@ xfs_stat_blksize(
>>   	return PAGE_SIZE;
>>   }
>>   
>> +void xfs_ip_atomic_write_attr(struct xfs_inode *ip,
>> +			xfs_filblks_t *unit_min_fsb,
>> +			xfs_filblks_t *unit_max_fsb)
> 
> Formatting.

Change args to 1x tab indent, right?

> 
> Also, we don't use variable name shorthand for function names -
> xfs_get_atomic_write_hint(ip) to match xfs_get_extsz_hint(ip)
> would be appropriate, right?

Changing the name format would be ok. However we are not returning a 
hint, but rather the inode atomic write unit min and max values in FS 
blocks. Anyway, I'll look to rework the name.

> 
> 
> 
>> +{
>> +	xfs_extlen_t		extsz_hint = xfs_get_extsz_hint(ip);
>> +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
>> +	struct block_device	*bdev = target->bt_bdev;
>> +	struct xfs_mount	*mp = ip->i_mount;
>> +	xfs_filblks_t		atomic_write_unit_min,
>> +				atomic_write_unit_max,
>> +				align;
>> +
>> +	atomic_write_unit_min = XFS_B_TO_FSB(mp,
>> +		queue_atomic_write_unit_min_bytes(bdev->bd_queue));
>> +	atomic_write_unit_max = XFS_B_TO_FSB(mp,
>> +		queue_atomic_write_unit_max_bytes(bdev->bd_queue));
> 
> These should be set in the buftarg at mount time, like we do with
> sector size masks. Then we don't need to convert them to fsbs on
> every single lookup.

ok, fine. However I do still have a doubt on whether these values should 
be changeable - please see (small) comment about 
atomic_write_max_sectors in patch 7/21

> 
>> +	/* for RT, unset extsize gives hint of 1 */
>> +	/* for !RT, unset extsize gives hint of 0 */
>> +	if (extsz_hint && (XFS_IS_REALTIME_INODE(ip) ||
>> +	    (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN)))
> 
> Logic is non-obvious. The compound is (rt || force), not
> (extsz && rt), so it took me a while to actually realise I read this
> incorrectly.
> 
> 	if (extsz_hint &&
> 	    (XFS_IS_REALTIME_INODE(ip) ||
> 	     (ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN))) {
> 
>> +		align = extsz_hint;
>> +	else
>> +		align = 1;
> 
> And now the logic looks wrong to me. We don't want to use extsz hint
> for RT inodes if force align is not set, this will always use it
> regardless of the fact it has nothing to do with force alignment.

extsz_hint comes from xfs_get_extsz_hint(), which gives us the SB 
extsize for the RT inode and this alignment is guaranteed, no?

> 
> Indeed, if XFS_DIFLAG2_FORCEALIGN is not set, then shouldn't this
> always return min/max = 0 because atomic alignments are not in us on
> this inode?

As above, for RT I thought that extsize alignment was guaranteed and we 
don't need to bother with XFS_DIFLAG2_FORCEALIGN there.

> 
> i.e. the first thing this code should do is:
> 
> 	*unit_min_fsb = 0;
> 	*unit_max_fsb = 0;
> 	if (!(ip->i_diflags2 & XFS_DIFLAG2_FORCEALIGN))
> 		return;
> 
> Then we can check device support:
> 
> 	if (!buftarg->bt_atomic_write_max)
> 		return;
> 
> Then we can check for extent size hints. If that's not set:
> 
> 	align = xfs_get_extsz_hint(ip);
> 	if (align <= 1) {
> 		unit_min_fsb = 1;
> 		unit_max_fsb = 1;
> 		return;
> 	}
> 
> And finally, if there is an extent size hint, we can return that.
> 
>> +	if (atomic_write_unit_max == 0) {
>> +		*unit_min_fsb = 0;
>> +		*unit_max_fsb = 0;
>> +	} else if (atomic_write_unit_min == 0) {
>> +		*unit_min_fsb = 1;
>> +		*unit_max_fsb = min_t(xfs_filblks_t, atomic_write_unit_max,
>> +					align);
> 
> Why is it valid for a device to have a zero minimum size?

It's not valid. Local variables atomic_write_unit_max and 
atomic_write_unit_min unit here is FS blocks - maybe I should change names.

The idea is that for simplicity we won't support atomic writes for XFS 
of size less than 1x FS block initially. So if the bdev has - for 
example - queue_atomic_write_unit_min_bytes() == 2K and 
queue_atomic_write_unit_max_bytes() == 64K, then (ignoring alignment) we 
say that unit_min_fsb = 1 and unit_max_fsb = 16 (for 4K FS blocks).

> If it can
> set a maximum, it should -always- set a minimum size as logical
> sector size is a valid lower bound, yes?
> 
>> +	} else {
>> +		*unit_min_fsb = min_t(xfs_filblks_t, atomic_write_unit_min,
>> +					align);
>> +		*unit_max_fsb = min_t(xfs_filblks_t, atomic_write_unit_max,
>> +					align);
>> +	}
> 
> Nothing here guarantees the power-of-2 sizes that the RWF_ATOMIC
> user interface requires....

atomic_write_unit_min and atomic_write_unit_max will be powers-of-2 (or 0).

But, you are right, we don't check align is a power-of-2 - that can be 
added.

> 
> It also doesn't check that the extent size hint is aligned with
> atomic write units.

If we add a check for align being a power-of-2 and atomic_write_unit_min 
and atomic_write_unit_max are already powers-of-2, then this can be 
relied on, right?

> 
> It also doesn't check either against stripe unit alignment....

As mentioned in earlier response, this could be enforced.

> 
>> +}
>> +
>>   STATIC int
>>   xfs_vn_getattr(
>>   	struct mnt_idmap	*idmap,
>> @@ -614,6 +654,17 @@ xfs_vn_getattr(
>>   			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
>>   			stat->dio_offset_align = bdev_logical_block_size(bdev);
>>   		}
>> +		if (request_mask & STATX_WRITE_ATOMIC) {
>> +			xfs_filblks_t unit_min_fsb, unit_max_fsb;
>> +
>> +			xfs_ip_atomic_write_attr(ip, &unit_min_fsb,
>> +				&unit_max_fsb);
>> +			stat->atomic_write_unit_min = XFS_FSB_TO_B(mp, unit_min_fsb);
>> +			stat->atomic_write_unit_max = XFS_FSB_TO_B(mp, unit_max_fsb);
> 
> That's just nasty. We pull byte units from the bdev, convert them to
> fsb to round them, then convert them back to byte counts. We should
> be doing all the work in one set of units....

ok, agreed. bytes is probably best.

> 
>> +			stat->attributes |= STATX_ATTR_WRITE_ATOMIC;
>> +			stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC;
>> +			stat->result_mask |= STATX_WRITE_ATOMIC;
> 
> If the min/max are zero, then atomic writes are not supported on
> this inode, right? Why would we set any of the attributes or result
> mask to say it is supported on this file?

ok, we won't set STATX_ATTR_WRITE_ATOMIC for min/max are zero

Thanks,
John
