Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3EE716D56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 21:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjE3TRz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 15:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjE3TRx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 15:17:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BA8C9;
        Tue, 30 May 2023 12:17:51 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UE4Awj009447;
        Tue, 30 May 2023 19:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zjYVB+jHF0BlEYk3zqkQWPZV3//UO6NGbEFJATP8JhU=;
 b=rpxaINf6vjgp3Z3Umk7Vs7GVlEoNhZZGfbT1qVqNifzYe27XHnt4wrlHNzIeg3aQ8Us4
 +PJLTcdJuE9mKX/SvKLMk7YCmSuj9YqJUrdwb+bWYuew5h4N6/0qc2rU0Tgy7gkWp4Rc
 N71DFfifUb6U113pSfUBeAUcZWDSutzQTSYOiTsB60fyqAabiUWA1r0M5r/XVgdYYcXy
 BAjTNQTjZLDdXgFxMHWHSflIbKn7HjG8cQJoyyyZ2Jt/QJDJZtbV2IZmccBW/TN6yQjr
 AOhTuT+CFdV4o822Gts+2sAsufjvNxUgtwHmdXDvT48XvfARPJYOz0cjkkJKo4AIG7zg mQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmekmn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 19:17:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34UHmGDF003698;
        Tue, 30 May 2023 19:17:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qv4ybxykv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 19:17:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7tdop4AsIdzgcTa8vQ77/jWizrn5uZLaGMmVwQc+aRiutDzYOryn29WlAzMVuy7ImaaT4DK0SL+JLTdHoY6TJbWEWNAgexT/PhZ7UK9b5ksABKBO3wUzVMnZm4rmB6G5bsCiGnxnRgd1Zhv16UY6klMkWI/hreeeobW9Iy9oKN/+B4F8E04Uqyf5DRFs/EuAtY8bLic+jw1TD4X4aTZ1qssMibTGO60F68suw2dgqaR5/D+mncSIgIlo+Deymuu5eFFsuf9yIRfAkwAczincPv2xV39kKiZyMgYGla5Q7YgHapG8ONrhtEjJ0Bq/KOZMJUXhWebIGxqi/YIMY97wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjYVB+jHF0BlEYk3zqkQWPZV3//UO6NGbEFJATP8JhU=;
 b=Yf69dBP5FunHjA6+/Cf2xrxk8bISedfeEuuJu+oy/Q0YeI96d6gb34FySE+tRKk07D1csyfDHMt0J9ugH4Ev7jQLjwtmEz2EZ+Yd7JvfA1mjxlitBs1pNPn0yg1f2IlPUsEP+MOwMZokC+Xp6XnkyCHI+NHkY2i7SLCzQbb7xLAtGy8BXqfAPCaDoYli+pgf+bXGIW2v3CEfB8gdDBy6T/kYpKsYKmZ/3BRhbYpTB8PGmKw5IIpfqXFwXJoOnXoKY7y8kjapfR9UyvcGWVgh2fdqk8238kwzqjZlEqwAX2RbHKcNtUCOHuISIqLoedo5fJfFUfVqf15rWvj0Jw4Ytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjYVB+jHF0BlEYk3zqkQWPZV3//UO6NGbEFJATP8JhU=;
 b=DPXTsMR4NA5aoWKF6ZKmP8bFsb++WQ52nBSE0I+z5IDBOsAguT9WQRaEtKsU74DjeeRdZDbKqsKM6S9YMj697kqykTJINpAWsKveW4Mea1jenMRyq9FazP2rmpxKVoKqZUKqmPbRJWXOQaoZ59K8/p7HPzJQLkFgfnjxUk/Bv3s=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ2PR10MB7584.namprd10.prod.outlook.com (2603:10b6:a03:547::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 19:17:26 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::256d:125b:8053:eeb9]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::256d:125b:8053:eeb9%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 19:17:26 +0000
Message-ID: <cc03b826-5e0e-8535-627f-71ca3c07a7a6@oracle.com>
Date:   Tue, 30 May 2023 12:17:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 1/1] dax: enable dax fault handler to report
 VM_FAULT_HWPOISON
Content-Language: en-US
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, willy@infradead.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230509054714.1746956-1-jane.chu@oracle.com>
 <20230509054714.1746956-2-jane.chu@oracle.com>
In-Reply-To: <20230509054714.1746956-2-jane.chu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:806:122::20) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|SJ2PR10MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: 6baa10d3-4563-4837-2caf-08db61428122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g1hHnw7+8HfkJdXTCmx9cDz7q0UfIVP4EbYxLitTBoDJBEAVv53aW+hn45c5wvxeIhvliOR/yGErzozvMxe7+CHXEr3siD4y+d2PHDL9cro0ynmE7vKuzOED9z4XFHBnHvCJYomHevNkU3Y4ONLXpdMQTIZkKfOLPLp17gLAkyDHJF5RIYSh0aa9cTx2E2wzAWZVUvl75fC+jZlHwjwmw5gxoPvSokxMnoKjks/CCCmrJN3putHQuVIu/t1gANGgfv11pf5+bzmN1RBq54CZD+gs348oekW/3Wl9OJF/JJKTAAYWJfTF11YUR04C/rRRCwE8/46Xcnm9evzmcZodreb2cVjRLDpZSBZBoniRG+u0jTgT31WnEwfkhigz02kcoDzuwTFDSM9V/fQ51aw2aJJa3J8bCsoqIs/vKPNlbNxWrkMkDqiR4NTJKdz+l9mW3FqjOBsRExz+yIp+rQfpCPw4NO4do6df+YCnepOHCDGzAo84WkGe1AbiFHDrbV3HEHm1847iV1OTM2hDCw6BlQ2D/cpLp1ekg6fBYekh+dG9KorHxjihaLzLxa+6C9yREJwhJUQqjt2PsGEVa5R5RH0Ox0FB8rnCV/T+wRZz3eEub0lHoZT1gLWBTlV5iJHx7eYGF9MehyVEOlCkF6gYOn+MJ3QgLzdNiUW0yEdNocU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199021)(6486002)(26005)(6506007)(6512007)(53546011)(186003)(6666004)(2906002)(316002)(5660300002)(41300700001)(7416002)(36756003)(44832011)(8676002)(8936002)(478600001)(921005)(38100700002)(31686004)(86362001)(31696002)(2616005)(66476007)(66946007)(66556008)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czc3ZmF6RmlzWDQrdE43RHpvZVkrd2VLQjRUa1E3UFNHVVhmZUhySUN4UVVx?=
 =?utf-8?B?N0gwUFU3b3A1b3U4d0xIVkQ2MXBjMC9sdW9SWG1Dd0ZVMXR6eC9TYUs4VEQw?=
 =?utf-8?B?R3M5c3pOb0Z3T3ArOVI0VHcxei9jcHFUZFJhZWdBYURFVjhJWUhQOW5QVlpL?=
 =?utf-8?B?eFVteWNFbmtzUmNpYlJmb0N4encyS1NaN3o4TmJPalF0Q0cvRjl0VU8ra3M4?=
 =?utf-8?B?UWdnbjhWMDJaVVM2elNzZzJJOG1jMEozWEpFUXFDZGdpaVNucW11T2VwSGUr?=
 =?utf-8?B?eWxJTFM5Yjh2S1ZBTHp2WWNvanBzTlMydGF0RUIzWm1jTjA0WEk0WndBOFI3?=
 =?utf-8?B?aC8xcHFpOGpTQlpxY01Ic0hyQVE4TWRLUHhpWUJ3NU84YjM4VHpHMXQyQTJE?=
 =?utf-8?B?VzVseDRpS2hXQzA1YWZvYnhUZFd6OExMUmxta28vbCtpTTRCSWtZejdyYi9a?=
 =?utf-8?B?SFRaUm9RekxXdUdxbnZPVGIxMnJmYXRPejlBNXp1eTBndjJETzEyWVVyRHF1?=
 =?utf-8?B?WE9OWW4wU29WUXdzZkdvejVBUldCSlhwVkNhVzN4ZTAxK2UyY1h5dUEwWXZn?=
 =?utf-8?B?cHRnMmV3bFRwTjVOaVBQaVoyMzljTUgwdzk5WjBBczJ5MTJIck5NVHlibUVn?=
 =?utf-8?B?ZXdDZUw0L3Y4b0hSR25MaXJHMk15S0tiRDI2M0V6SVlZSjZuSDlYUDEwMTFO?=
 =?utf-8?B?dHVvd3ZuZXBVVWtaVW0vU2QrQUVjNnRiU3pENzdNWDRBSm5FZ0l1clh5bjNE?=
 =?utf-8?B?ZmxseEszU3U5K1lvYXB0Tko3SjdhNUlqWDFaYk1pZ1ljSCtjYXlNVlhyckFZ?=
 =?utf-8?B?ZFRUSHV4dHZGYjdiV1ZCWHBjd0JaMzROcENtWjA1R3RlQndWamU1dk93VHl5?=
 =?utf-8?B?S29EWGM0S25qTmNiVHg1SWVEc00wRjgyRWFLazVGNTdvZEVGaFpFNGRBenhT?=
 =?utf-8?B?ZGRjb1JiRk1xcUJSa3ZZWG1xcFdEMmU2NUx2T1p1TUREUXJoYXRCM1gzQTU5?=
 =?utf-8?B?M3FEejJJZVNjSitjbm1LWFhBQi8wNE9BNUNBeFhUbGdFbGszNlBqU0pnZnd4?=
 =?utf-8?B?V2wvZUdPejgrazI2YXY5ZDVZYTNlQ21GQ0IyblMzY1VjNnQ0N2VkVld0YXMr?=
 =?utf-8?B?WTZZY3A4MFpvWjhXdnRqdU1rSlgxTjdSdzk4SHp3RGwzem5vY2FVRUhJS2FI?=
 =?utf-8?B?dG9XSTU4S0RkWURpNUp2UFF5enJvL2oyVzBEVVU3UnEyZTBiSGZZZ3haekJX?=
 =?utf-8?B?c0ZNc3NZN2FBRW5JeVVJci9PWGxDV3NTZkE0Qkh2SVlnblc3eGlpTTBsVGFW?=
 =?utf-8?B?aDMxbmtEeWdOUnFwcURNSUhqRndWVjNFVTNBNTlJZktWeVZKQTZWNTk1N1B4?=
 =?utf-8?B?SndoZThvd0lCS2ZvNForcDI2MDQ0Si8xb2RVNk1obmQxY1dIbERIUkNuSVhv?=
 =?utf-8?B?bVhNMlQ3VjJVL2krRjAvcXJ4N2F4WmdtSTg4UGxvY2N2eTZOWHdQOEpzWWl1?=
 =?utf-8?B?Y0pzUE1tZEw1MURhSFA5QzVqWmpOSlFIUG5MQ29kaTRlTHFBSjV0OFBWdGN5?=
 =?utf-8?B?VmFzZFNCMlI5YTh0ajhnR0JGS0FDdDAzSGFHTHNLTDJDRUVaZXdXTGFtMGhO?=
 =?utf-8?B?YW0yYUk3aUF3R2Z4aXVNSjVwRXhMZmxyVTlVRHFReFZXMHJBWHNLQ2xXd1Jk?=
 =?utf-8?B?Z29PdEpJY25NT1E5M25SMUZtWkZZZWFVYXBHK3ZMaWZtc2lFZnZmaEpWNHJa?=
 =?utf-8?B?ZlA3MitWVUw2TW9CbjNteHpLelhZbzE3KzNTaHZXTjJDUTlTNlJCcG01emQx?=
 =?utf-8?B?Zkt0eCsvY3Z0WEFsY1ByN241SGNyVm1ZVkxGR1pFc1F2b3FHT2ZwQ1N4M09X?=
 =?utf-8?B?VmZ1MGNiRE1PU3hnTjI0aHlYaENZSWRPQXlxS1RVOFJjVk5EVFhxMmFiSmFY?=
 =?utf-8?B?TGxERFpSUFRkU296NXdZMHVoMlY4a0dhNzJld0dkdjJTbXhnTUdIOUwwOFZ4?=
 =?utf-8?B?UHYyUjEyd2JETHpkTkMyRStzYytmdlJJRk42aVRTSmF0MDFOejVtNEFkdjZi?=
 =?utf-8?B?OVdpQWdOUjdMRExCQkN5NmdCbloxSi9vZVJMc2F3RW5tWFBFWlJUeXFURUdQ?=
 =?utf-8?Q?4zUYOkyg20JZCFwPj/3NErytd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NVhudzNlekRTaE5sWU5GelBuZUdnVlFPNzhkN3I3MGoyMlkyVENhZU1FKzMz?=
 =?utf-8?B?RTBwZ1UwZngrVStGNTFCOTYwMFovenQwZXVKVmdNVDk0Rjl4Zk50QzAyK2VB?=
 =?utf-8?B?R0d4c2ZHaStzN2xZUDB0Y3RkV09vRnQ4NFErMmQzc081RE5ERzcrZlpTRlNp?=
 =?utf-8?B?Ry8xajBaQWFRRkNHRzhTb1dSS1dmQWs0RGNEODlhSTZYSnY1MlBOaGRMMGRt?=
 =?utf-8?B?TUFJMytuTjVaZmpuZXdIc1Q5NjA3WUNCN0NhQ0JHMTc4alZ0R1IzdDByYWx0?=
 =?utf-8?B?NmJSTzVnOXM5K2x3LzVFMkpNeHJ5NHJwREtDTFhIN3MxczdnVFhiM0t1NDY2?=
 =?utf-8?B?V0NBRWNqZ1J0M2tiK0pyVXMxOWJGM3V4QU15WmE3VDdkN3lJV0QwaGYxZjM5?=
 =?utf-8?B?UitvTjAvUC8xemN0UG5CazJiQ2JwRm1wYzBrcVk5OERicmlDcmQydENFRW5T?=
 =?utf-8?B?L0NacmJnWkNMeU1QUzlHdlZkV3VWak5jb3pLdWtBT2Y3L2NRaitldTRMalRN?=
 =?utf-8?B?RFRFZHZORDVsOG50YUVCdnRTVDRTWW1TRktDOHQ5ZWgzTW92Z0dabWpTQ2Yv?=
 =?utf-8?B?eFY3MU16Wlp3Rzl5RkVGZVBiK2tlSU5KMXJDWTVtMFQ4UmJPcUViRkhUYXRl?=
 =?utf-8?B?RHJlNDJCenZLRnZvSmhWU0R2SWtzbERaUUJ1TGNUcDNIS3ZjMmJoTU15TjNs?=
 =?utf-8?B?OXZzMnQ2ZzRtZzhRcFNpdW9TRzRDaWpuQmVQc2h2UEhwWEZ2Y3hxWmFQcURB?=
 =?utf-8?B?RTJlZ1lrZURsV09aQ0FwRHZuWEJHZHhJUGNXeklLWkVJVDRwMm9HN3QyUlJu?=
 =?utf-8?B?eUp4MGR2ZlZUVTZBRFRtWUcyYkNBbDRaakxlZDdQUUxuUHpzSGU4VTBILzM1?=
 =?utf-8?B?RkJ0elZFN0U3NUZXWjBpZnBaMnBMZnNreWY0Tm1rTDh1YUVpVnFlQW1kVjEz?=
 =?utf-8?B?VDBFL3NXaGNYRzFRZEZWZVNRRlV6Vm9kMlNDVmg3MHRVZ1NEMWJSR2dicXh5?=
 =?utf-8?B?YzBOdFlKVFBvSStQMm1wQ3hscHRNNitlR0RHWUhtRWs3c1hzU3ZsOVl3eGZO?=
 =?utf-8?B?dHZaejFLVWNQZldhcUdSMytqQmNCWllrREhXUE4rMHljekh1VVI0ZTEvTG9p?=
 =?utf-8?B?STZxb2xhUUxibjR2MlVXenhZamtjVU82NzlSOGlldkRXLzluN3BRS2xLaHZy?=
 =?utf-8?B?eXBIM1JtYVc4Z2tmc1lTQUhZeDNoMnYxRmlWLzBjWkJxS0V6WU1RWWJ3bVUy?=
 =?utf-8?Q?Ym+yHO/KYtr8q4W?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6baa10d3-4563-4837-2caf-08db61428122
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 19:17:26.7228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ieSB38ltbph3vYlsVww8q3cLLLHcHYwxjlyX2ldGH4GN9LHl3Zt5fCN7o5z9DhIij/j/zxYWyxEiqlTBc85GjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7584
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_14,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300155
X-Proofpoint-ORIG-GUID: stL5wcl_CksZDSL55kpyydIJrQjRuzpX
X-Proofpoint-GUID: stL5wcl_CksZDSL55kpyydIJrQjRuzpX
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ping... Is there any further concern?

-jane

On 5/8/2023 10:47 PM, Jane Chu wrote:
> When multiple processes mmap() a dax file, then at some point,
> a process issues a 'load' and consumes a hwpoison, the process
> receives a SIGBUS with si_code = BUS_MCEERR_AR and with si_lsb
> set for the poison scope. Soon after, any other process issues
> a 'load' to the poisoned page (that is unmapped from the kernel
> side by memory_failure), it receives a SIGBUS with
> si_code = BUS_ADRERR and without valid si_lsb.
> 
> This is confusing to user, and is different from page fault due
> to poison in RAM memory, also some helpful information is lost.
> 
> Channel dax backend driver's poison detection to the filesystem
> such that instead of reporting VM_FAULT_SIGBUS, it could report
> VM_FAULT_HWPOISON.
> 
> If user level block IO syscalls fail due to poison, the errno will
> be converted to EIO to maintain block API consistency.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>   drivers/dax/super.c          |  5 ++++-
>   drivers/nvdimm/pmem.c        |  2 +-
>   drivers/s390/block/dcssblk.c |  3 ++-
>   fs/dax.c                     | 11 ++++++-----
>   fs/fuse/virtio_fs.c          |  3 ++-
>   include/linux/dax.h          |  5 +++++
>   include/linux/mm.h           |  2 ++
>   7 files changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index c4c4728a36e4..0da9232ea175 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -203,6 +203,8 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
>   int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
>   			size_t nr_pages)
>   {
> +	int ret;
> +
>   	if (!dax_alive(dax_dev))
>   		return -ENXIO;
>   	/*
> @@ -213,7 +215,8 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
>   	if (nr_pages != 1)
>   		return -EIO;
>   
> -	return dax_dev->ops->zero_page_range(dax_dev, pgoff, nr_pages);
> +	ret = dax_dev->ops->zero_page_range(dax_dev, pgoff, nr_pages);
> +	return dax_mem2blk_err(ret);
>   }
>   EXPORT_SYMBOL_GPL(dax_zero_page_range);
>   
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index ceea55f621cc..46e094e56159 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -260,7 +260,7 @@ __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
>   		long actual_nr;
>   
>   		if (mode != DAX_RECOVERY_WRITE)
> -			return -EIO;
> +			return -EHWPOISON;
>   
>   		/*
>   		 * Set the recovery stride is set to kernel page size because
> diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
> index c09f2e053bf8..ee47ac520cd4 100644
> --- a/drivers/s390/block/dcssblk.c
> +++ b/drivers/s390/block/dcssblk.c
> @@ -54,7 +54,8 @@ static int dcssblk_dax_zero_page_range(struct dax_device *dax_dev,
>   	rc = dax_direct_access(dax_dev, pgoff, nr_pages, DAX_ACCESS,
>   			&kaddr, NULL);
>   	if (rc < 0)
> -		return rc;
> +		return dax_mem2blk_err(rc);
> +
>   	memset(kaddr, 0, nr_pages << PAGE_SHIFT);
>   	dax_flush(dax_dev, kaddr, nr_pages << PAGE_SHIFT);
>   	return 0;
> diff --git a/fs/dax.c b/fs/dax.c
> index 2ababb89918d..a26eb5abfdc0 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1148,7 +1148,7 @@ static int dax_iomap_copy_around(loff_t pos, uint64_t length, size_t align_size,
>   	if (!zero_edge) {
>   		ret = dax_iomap_direct_access(srcmap, pos, size, &saddr, NULL);
>   		if (ret)
> -			return ret;
> +			return dax_mem2blk_err(ret);
>   	}
>   
>   	if (copy_all) {
> @@ -1310,7 +1310,7 @@ static s64 dax_unshare_iter(struct iomap_iter *iter)
>   
>   out_unlock:
>   	dax_read_unlock(id);
> -	return ret;
> +	return dax_mem2blk_err(ret);
>   }
>   
>   int dax_file_unshare(struct inode *inode, loff_t pos, loff_t len,
> @@ -1342,7 +1342,8 @@ static int dax_memzero(struct iomap_iter *iter, loff_t pos, size_t size)
>   	ret = dax_direct_access(iomap->dax_dev, pgoff, 1, DAX_ACCESS, &kaddr,
>   				NULL);
>   	if (ret < 0)
> -		return ret;
> +		return dax_mem2blk_err(ret);
> +
>   	memset(kaddr + offset, 0, size);
>   	if (iomap->flags & IOMAP_F_SHARED)
>   		ret = dax_iomap_copy_around(pos, size, PAGE_SIZE, srcmap,
> @@ -1498,7 +1499,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>   
>   		map_len = dax_direct_access(dax_dev, pgoff, PHYS_PFN(size),
>   				DAX_ACCESS, &kaddr, NULL);
> -		if (map_len == -EIO && iov_iter_rw(iter) == WRITE) {
> +		if (map_len == -EHWPOISON && iov_iter_rw(iter) == WRITE) {
>   			map_len = dax_direct_access(dax_dev, pgoff,
>   					PHYS_PFN(size), DAX_RECOVERY_WRITE,
>   					&kaddr, NULL);
> @@ -1506,7 +1507,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>   				recovery = true;
>   		}
>   		if (map_len < 0) {
> -			ret = map_len;
> +			ret = dax_mem2blk_err(map_len);
>   			break;
>   		}
>   
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 4d8d4f16c727..5f1be1da92ce 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -775,7 +775,8 @@ static int virtio_fs_zero_page_range(struct dax_device *dax_dev,
>   	rc = dax_direct_access(dax_dev, pgoff, nr_pages, DAX_ACCESS, &kaddr,
>   			       NULL);
>   	if (rc < 0)
> -		return rc;
> +		return dax_mem2blk_err(rc);
> +
>   	memset(kaddr, 0, nr_pages << PAGE_SHIFT);
>   	dax_flush(dax_dev, kaddr, nr_pages << PAGE_SHIFT);
>   	return 0;
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index bf6258472e49..a4e97acf60f5 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -261,6 +261,11 @@ static inline bool dax_mapping(struct address_space *mapping)
>   	return mapping->host && IS_DAX(mapping->host);
>   }
>   
> +static inline int dax_mem2blk_err(int err)
> +{
> +	return (err == -EHWPOISON) ? -EIO : err;
> +}
> +
>   #ifdef CONFIG_DEV_DAX_HMEM_DEVICES
>   void hmem_register_resource(int target_nid, struct resource *r);
>   #else
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1f79667824eb..e4c974587659 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3217,6 +3217,8 @@ static inline vm_fault_t vmf_error(int err)
>   {
>   	if (err == -ENOMEM)
>   		return VM_FAULT_OOM;
> +	else if (err == -EHWPOISON)
> +		return VM_FAULT_HWPOISON;
>   	return VM_FAULT_SIGBUS;
>   }
>   
