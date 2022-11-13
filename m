Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B861627141
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Nov 2022 18:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbiKMRai (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Nov 2022 12:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMRah (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Nov 2022 12:30:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9331055F;
        Sun, 13 Nov 2022 09:30:35 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ADDTf8o000715;
        Sun, 13 Nov 2022 17:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Ac6ZljjGMOTjbfpJLbRhHbYUj5yyjUbg+oi5X2azArY=;
 b=leXMA28/SS043VULeyGAa73z28Y6D2Qw1+noyQGuJwU4sDGwRo+M2wLf+xW0vWXzfoTT
 w4IPosjzxx2g7nZqeVYl1098c9O08ELYlAeQ4Ut4Rz9KRD8OD7W3N+AYp6vG//biDO0n
 xSa+o8tIpnc5B+xGyWKt8c7o71EoKaTXJsRrRxoJjOZtTnKYItCtG03FwpQXi05csBGV
 sTBr2BW+GDdO0p3FYti59Z7NacRQof/MGKRQvu444gxP33GSANBG49Ok1jGjC/Ho6JkP
 KaVZehz2lSW8FQw6Wp7YTNRAriOwXHvcn5AczkHrVLZSqknc/CbPJ8NuEKmx7wuu0dHv WA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ku1gwg5v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Nov 2022 17:30:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ADG6t0K004249;
        Sun, 13 Nov 2022 17:30:29 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x3947e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Nov 2022 17:30:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eS5NmEtCQsRTRWJM946wkmRaeK6+77UBkM69SsbQSmzbOl0l8tABt72cVOcX0eudaoSgf/JVTY+GVrw8QPu+bfgCcUHW/gQ8i3eZ28wmOoXIqf7rsBj0t81eVD5bnB/G3qWcf8Gnt5yK5jfLLG3ATKcRR+RO/pAxnNKyksnaYLTWX9OnurnTLt2oi5Iab9LFpMhSlPH86GxjVTR5esn4Hq1ApiFCv87ZPbun38GNmVwqviMAWXI+ChmpNl/HjIPjvuCrdfXb9qnYDdjnYi1qJP8zlHO5mAqe40c18RJQ98ZjgBgMa06OHhKjsfOgArfA7bmp1bkH8Z5qT7bHRwxwLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ac6ZljjGMOTjbfpJLbRhHbYUj5yyjUbg+oi5X2azArY=;
 b=Y4O3Cm4eKyEhtz4lfKy3IYsfi77P0mVW7feeoRJzysobT2MQfSczqPi/iMxORMl5iXVPHiDdEYo4UZ+ZH/kvS5rpWvoyxwSTJYS4fyoDbGrjjyx+kjcRiBJf84XbCYG3aO17I325f5OdRUBicWoj2tRDtH7NKtafiIK25AjYHDBBkbuZ9OReaxSDQBOAVBdxdsg/lM4pqtL2uvX4kRq7cxnLDSdhBUzXcpR4LLamdy9FQm7tqf4ykYUPIY7ffazh2CBtXOEIRQdfM22/Uz5iV/ieCDUXVaclmivpzIAUF5ljiMnNwoShaW99Yjo3kb/XWAR5ZnKIfFaHAtE5qsG5/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ac6ZljjGMOTjbfpJLbRhHbYUj5yyjUbg+oi5X2azArY=;
 b=Y2pXVRFEKP9xrwxz4m1uvM6bwM/GLVbVHRk7B2jr2SRPH0VHzuwSWbxyTCPY6oqTw1ansgiGeJrBM14JGcWBWeYTwjvrKd32+9QOX1jLyvd9SowMRCWPSP2bL67UFjnRusBIs/hhN39Cfzxq0fSabgwwOixSfbvibjedHXI5AMk=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MW4PR10MB5727.namprd10.prod.outlook.com (2603:10b6:303:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Sun, 13 Nov
 2022 17:30:26 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::8b38:e682:1a6c:7b66]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::8b38:e682:1a6c:7b66%9]) with mapi id 15.20.5813.017; Sun, 13 Nov 2022
 17:30:26 +0000
Message-ID: <74969b22-e0b6-30bd-a1f0-132f4b8485cf@oracle.com>
Date:   Mon, 14 Nov 2022 04:30:19 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [RESEND PATCH 4/5] kernfs: Replace per-fs rwsem with hashed
 rwsems.
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220810111017.2267160-1-imran.f.khan@oracle.com>
 <20220810111017.2267160-5-imran.f.khan@oracle.com>
 <YvwdShstDCK+uQ+R@slm.duckdns.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YvwdShstDCK+uQ+R@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0308.namprd03.prod.outlook.com
 (2603:10b6:8:2b::31) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4468:EE_|MW4PR10MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: f32ac205-271b-45a2-d7af-08dac59cc05a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: blw/WxYdwLlMDkb7DEY483Hd4fiaJlQPOWXDJMZp+Prip4i/P2mk+c1omN/u8fhxtRhFLl7n6bu3gJxU5vlStqEOHREpvqdMDEJkigs3dJ58tk32h8x7nVAR5TUV3pb0/bYZ8AkPChv+vpAmYolUlWyubCUyvd/Ok6TiFo971tezY3D4lXjdGRcH0FMsoqKDxIu3bACzaORUSA7ydWWQ7pokaX8jK8i0c710a2rFgTOQ08FRmPaqn4ksWKFD+VmxCuLSHZ9OmLcc6cE0AuQzkWLUpl19baEvbJlb5pyU31GC/qxnaX2VKVmq9oY02IpL0Fy/ORYIJvRq/sP7jVoOZOr2mxDoHtCP51S8/SbQXIzKDvNzcr73qEBPINmdSXkifuDj81wCbx7P085LC1zWUeagZvGlVy4Eo4gJ49XAe5mXCJZFziJi2KuobEkYrnU1MBkpH6hukyVOaacBx4TBNVcjZU1f1eUC/Qw6nK5fXvLMA80RsTUTqAXEHv8cyOCjkRdxZbj7rxMl/M1FOYvhZsRQQZcpd4YpptWy0nBa9DjrJZUWGfHuICiAAm22dogXB5d7k7lag+UmdNGE5O5k+P+ygzDdjO5AqekZ7FUqYMsiqJcm8f4bkvps/owEk2FGlQnGiCTD1nFjjITauyZxf8DEPmqx0tbbI3xyj9xwx7KOIEYo8IiEvmSl5j7NJHgsv2xX+PX05K62bDTORQOCr+EBnM2kGF7vUanzh2rlw+yeBYitCffnV30ezKIwExZA407BnsMlhIqLHsNn1zczA/w+GbNPLEOrvb0ClPuUCRin4ndRVTIhnjvLljFJ5cE8ePpjecoOCkonRUkd8/PK+7Op5HQpIwbYtus5EdzG+sc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199015)(66899015)(31686004)(5660300002)(36756003)(30864003)(2906002)(8936002)(41300700001)(966005)(31696002)(6916009)(316002)(478600001)(6486002)(8676002)(4326008)(6506007)(6512007)(6666004)(26005)(66476007)(66556008)(66946007)(86362001)(83380400001)(186003)(2616005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUZOTU1jVlJVMkt4NDh0TFlsdlNKYmxyZ1BTb2tEY1dzR3VSeDJmc0lobDVP?=
 =?utf-8?B?cWdvZzh3VXZVVkFaTDNCaFBXVzQ1UGErejdNbUZQRlVyZkdFZTBtUFpBemtS?=
 =?utf-8?B?YWtseU5mcGRrSXJoL09VbFhYV0RwZjByTGY5OCtVYzNibTA1UG16ZERSWnhV?=
 =?utf-8?B?THoyYzgzc1BuZ25ST3lyM1MxOWtUVUt2bEdRbWJ5eUhtaTdhVTlPdzRTWkNP?=
 =?utf-8?B?TjN1OU11aStUR080U0xkR0hLenFKaXpYNTJUODZRYkZnRDYyYzViMHBPbXdx?=
 =?utf-8?B?d2MvYzFYMTNtU3YxZUlKaHl4OUswb2Y0TEptUnpERnBFMC9EOEJveWNqOXVW?=
 =?utf-8?B?dWxTblVMWC9GVmk1TGRrTitaM1dzc20xY2d6Vk1Hd1pBWU9zNjZFZkNqVXYx?=
 =?utf-8?B?ZHVtUStLV1NIL0ZqRFE3SS9hbGNIdHZtOU9PSXlCemkxVDJoMURQK0ZONlRs?=
 =?utf-8?B?UzE4bUMzNFdsMFFmclRZaDB4Wnc3R25qWnZxMFZMOFlEdDUydmc3MFlZQ2NO?=
 =?utf-8?B?enZwNk1HemE4K21jR01pUEp0NzhTZ2F6ekhvUmFKbUg4TTh5MXh4MW1UQW45?=
 =?utf-8?B?dVphVTZBenV5OVgzaDBFQWU4bHZ2Z3ZGOW02K09xMUtKa2J5S0NkUUtsU2I2?=
 =?utf-8?B?a0ZrSnZUb1djSXRzTnljelBwWkhOWlU3bUdDQ1VzOWFMWWN1K1FseUR6Y1d0?=
 =?utf-8?B?cFZCSTQvK3YxS1JBbUE2dS8ybW9FRWVSZWxnVGRHN0tiMXExcWlTZkFlWlNY?=
 =?utf-8?B?UTdrblZrRmlLWHpTQ1gzVWtFQkorNkFwY2hWWGpoUktUalJmTGlYZEIwZ2R2?=
 =?utf-8?B?RXJzandlTlEvTVlzNkE0L3hDamlpdWh3Qnp0UHZUOGdWZGVEWE1ITEcwSGRz?=
 =?utf-8?B?M0xjQTlncGJYVDdrSnB1dVcrMm4zeG9Da2hSdzBmQ1ZiV3lmMHJITkdmTDNU?=
 =?utf-8?B?enBzT1Z1N0lJR0pUWjNHZVg2TUsvWktoK1NPUUhKaVdaNi96dDVBWEZUN1JR?=
 =?utf-8?B?VlRhYTloRHdIN2VIM0tXMzRBcnRzV1ZTU21ERUtSZkpMMW0rQ2ZLTXI1ZURD?=
 =?utf-8?B?cUpJc0hQSXhvNjZjVEVvVnNFdHE5dHJtL2pkLy9kSlA3UGZ1Rm5zUDZuMHVS?=
 =?utf-8?B?NTdPcXJKVGZ2SkwrRzc0ckNPUklRSUZlbFBRSmlwa1hZWVYvNklvdDdtdlRO?=
 =?utf-8?B?SitsTlRkemZmRGw3TFBGSm9NcW1UY1VnZjVvNWx6RXlweVlLZStJM2FYdnc0?=
 =?utf-8?B?NERRT0R5K1NPbnRpVU9Nd1pDengwaVdrSGJwUmZhdHMzNmxkbi93T0k2YTVW?=
 =?utf-8?B?Vnd0V20zWThkMDB3MXVaeFI1NjIyNHdZSUNZc1dkdE9XSkFSTk5xZ1ZTRHRV?=
 =?utf-8?B?N2pkaGNVVXRNMDZNWkh6V3MrTEo4TDlRdWJ2aXdYZTNJWkR4Q1ZHNmpyblVy?=
 =?utf-8?B?RTMvallrZ1EyNFFJakUzODNXNWZnbFBwU3NteGVDM3BSSWJvZ0NtWGtvbjMw?=
 =?utf-8?B?VHpRZUowcXlHMGhSVVdzNDFwUnV4NnZ3VWREODd5UisrT2RwbTJuTGdMU1Na?=
 =?utf-8?B?M0w3SWt1WUd4bCtMMzBJUVZCc3A4ZmVnbWZrYWxBVFhxcUVRRTZhTzBRNDc4?=
 =?utf-8?B?NGtqUFFwOUh5alJnU1F4aFBaelY3M0Q5WUY0cUZzK29WeG9KM1lGOHdWazVo?=
 =?utf-8?B?aml5RjZGV0dLZ2lxMjMrd1ZORzdtM3MrV3o4a3k2Q1o1WlZ2UHBhYkVzOFpJ?=
 =?utf-8?B?WUZhd01uSjQzdVhsN3hrbldITEtQRW1CbWkzRUtXNE1qSkdubkJkQ0V1V3dF?=
 =?utf-8?B?Y05qdnZuczJvQldHdWkza0F4WDd0a3JJNFZteU42MnRpTjJwYS9MQzN4R3Bj?=
 =?utf-8?B?MFdOUkhBR0hyZzNqSUhqcUxFeWFlMHFmY1lQRzlkQmdlVnFRWkIyb3JMQjQ1?=
 =?utf-8?B?c09TekQ5bUdJTFc4Rncra3EwdXN4aEdlOEZmU2s5ZElkUTVWNmRiMllxOEFn?=
 =?utf-8?B?WTBUUlZ5NFQwd0xLYm5tYVFiRFlyMkxFVmxEeDJOUFYyeEV6R1dwa2E5Nk4z?=
 =?utf-8?B?Zyt0Ykd1YUJlSzhjY0Q0cE8ybG8xTVVQMkhGMVZSUTJVZjR6ME12dDBIMkp5?=
 =?utf-8?Q?gqy2ZNIGHu8vgV0DUaOzPoQMX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VjdJMkJEZFZCdVVHTVl5UnF3TjU3T3N3T1h3dWdieW1yb2pFQ1IybnNhY1dQ?=
 =?utf-8?B?aXJVeFBGUjUzV3pYUlF0akdUVm5NVmg1cjg2S2xIbVUrRFZmOStialZmQVlP?=
 =?utf-8?B?NmtobkZ4UDQ1NTEyQnJlR2ZNWFJIY2t3VGtoRC9oOWdNeXlEeHlCUm5iWWhi?=
 =?utf-8?B?bUpqbnRxcUVyeERaVG5kRTFEK2Zaanc5R21xSHBVdXl1dG4yVS9jTGkxTS9C?=
 =?utf-8?B?MmRoL04ySTZSYVJoZ2p5UitBWmlVS2tSa2diRm1HUExuaDJJZGJXOFlWTjI1?=
 =?utf-8?B?N2J0SFhxT1NqcThNQXN5VThGVW9XaDN0S1QxUThYQUNYR2oyQVpCWTY5cHZZ?=
 =?utf-8?B?TGlGaUdrcG54alpWSVY3TXN5WUtHTFM2OHJVR3grZ1B4YTB1czREQ1RtZldr?=
 =?utf-8?B?anhYd3ZyT0ZlV0pZQ3cvRTY0QzNpUHF2aVQ3emtzd0FRU2hnY0Z1S3h6aFNI?=
 =?utf-8?B?UTJuQzUyRXh6K0RHV2toWjd1VkVHaEJFYjByTFBuVXl1Rm03ZGROOVpCK2JP?=
 =?utf-8?B?T25BUXRCbUZqcXVHQy80SVE3aVlLK3JkU2hGMTJPYWZtSWtUa2xUTzJGenAz?=
 =?utf-8?B?bVJoZ05VdWVvOXdhS3pQUUhndDJjUldWbXVpMGlaL1FYSGUzVmMzdi9UV3h5?=
 =?utf-8?B?YmtvVUdkbnBxZ2F4RXNiVEJHdTYxcjJpREU4VnFQODhqZXQ4N2pqTEFzcjZm?=
 =?utf-8?B?ZHdNbkJBWG5BRGxJS08zOE5PdC9PU3l2ZVBJV1Mvci95bURqRGNwREl1WmVJ?=
 =?utf-8?B?cnpnY1ZLNXB5cTMxVnRlUmpkbHl5RmxpcjZrSnhtUnVZQWpXRmg2bFVkdldw?=
 =?utf-8?B?SGRWWUxOeWhRS1hCUmNrdUFrV21pZVBVeVVZRVZTeXFmZEw2WFVkUXJFT0lS?=
 =?utf-8?B?enpES0MwZklBUUJpdTgySjh5a0ROQmVscENKWXFsNFN2WUNkdjlhWGQyVXJH?=
 =?utf-8?B?eDlBUkp6RXdtNUg3NHprMjcwcE1kUm5CSG9xVDJpQlc5aDBVaW1WaElVcito?=
 =?utf-8?B?M2EyUzNCNCs4MVJZWC9XS2NPR2lYaTBGZzl2TjA4WjZNNXVndEVPbWFWSTV2?=
 =?utf-8?B?Qm9BOVdBUE0wTW9SREJ2am40WG9QdUJoMDlvTDdWKy9HcHJ6RFJoeVFtency?=
 =?utf-8?B?Q1RSMkdwdVpyb2gxQmlmeVZ3T2hJNVRZRmdlMHJKWHdsaGpUYmF0MitoM1JK?=
 =?utf-8?B?Y3NyOGM1cDcvejVxejNMNEJQTzVGV3ExMkY1Z0ZxWWh5RFN2elhlVXg5SnA3?=
 =?utf-8?Q?0Ph0DPBf4O7240V?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f32ac205-271b-45a2-d7af-08dac59cc05a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2022 17:30:26.3781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCFJhfMhAZPMmlCiXa34hoanF/Rdo1ewl/wdmHxKocn+nMJ1cRCU6dweiJEKxPyiiwQKLJJMQkFGu+na8LPx0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5727
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-13_11,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211130120
X-Proofpoint-ORIG-GUID: 6o_d07CFxBYf-pmwd7nGmWDAlQwLBmgB
X-Proofpoint-GUID: 6o_d07CFxBYf-pmwd7nGmWDAlQwLBmgB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Tejun,

I am very sorry for replying late, I was away from work for most of
last couple of months. Also apologies for this lengthy reply but
I want to share some data here from recent experiments to see if
some alternative approach can be used here.

> * I find the returning-with-rwsem-held interface and usage odd. We return
>   with locks held all the time, so that part in itself is fine but how it's
>   used in the proposed patch is pretty alien.
> 

The interface for acquiring and releasing hashed rwsem has been
kept similar to interface for acquiring and releasing hashed mutex (which
was done in part-1 of this work at [1].
Could you please clarify which aspect of its usage you find alien here?
Probably there is some scope of improvement there.

> * I don't understand why the topo_mutex is needed. What is its relationship
>   with rename_lock?
> 

topo_mutex is providing synchronization between path walk/lookup and remove
operations.
While looking for a node we will not have address of corresponding node
so we can't acquire node's rwsem right from the beginning.
On the other hand a parallel remove operation for the same node can acquire
corresponding rwsem and go ahead with node removal. So it may happen that
search operation for the node finds and returns it but before it can be
pinned or used, the remove operation, that was going on in parallel, removes
the node and hence makes its any future use wrong.
topo_mutex ensures that for competing search and remove operations only
one proceeds at a time and since object returned by search is pinned before
releasing the topo_mutex, it will be available for subsequent usage.

I understand that kernfs_rename_lock protects against parent change but it does
not prevent against node getting delinked from its sibling list or getting removed.

Further during path walks we need to acquire and release rwsems corresponding to
directories so that these directories don't move and their children RB tree
do not change. Since these rwsems can't be taken under a spinlock,
kernfs_rename_lock can't be used and needed protection against topology change
is provided by topo_mutex.

In current scheme of things global kernfs_rwsem automatically ensures that
amongst move, removal and addition of kernfs_node, only one proceeds at time. So
operations like kernfs_walk_ns can complete without any node getting
added/moved/removed in between.
With the approach of hashed kernfs_rwsem, topo_mutex is being used for similar
use cases where we need to ensure that no node gets added/moved/removed during
an operation.

Ideally I would like to avoid topo_mutex because this too is a global lock but I
am not sure if for all kernfs operations we will always be able to get and hold
hashed kernfs_rwsem for all involved nodes in a consistent manner.

These were my reasons for using topo_mutex with hashed kernfs_rwsem. Please let
me know if you still find use of topo_mutex problematic

> * Can't the double/triple lock helpers loop over the sorted list instead of
>   if'ing each case?
>
Could you please elaborate this query? Do you mean list of nodes in a path or
list of sibling nodes ?As per my understanding even with triple locks there is
no way to ensure all involved nodes remain consistent.


Below is reasoning and data for my experiments with other approaches.

Since hashed kernfs_rwsem approach has been encountering problems in addressing
some corner cases, I am thinking if some alternative approach can be taken here
to keep kernfs_rwsem global, but replace its usage at some places with
alternative global/hashed rwsems.

For example from the current kernfs code we can see that most of the contention
towards kernfs_rwsem is observed in down_read/up_read emanating from
kernfs_iop_permission and kernfs_dop_revalidate:

	-   39.16%    38.98%  showgids     [kernel.kallsyms]      [k] down_read
             38.98% __libc_start_main
                __open_nocancel
                entry_SYSCALL_64_after_hwframe
                do_syscall_64
                sys_open
                do_sys_open
                do_filp_open
              - path_openat
                 - 36.54% link_path_walk
                    - 20.23% inode_permission
                       - __inode_permission
                          - 20.22% kernfs_iop_permission
                               down_read
                    - 15.06% walk_component
                         lookup_fast
                         d_revalidate.part.24
                         kernfs_dop_revalidate
                         down_read
                    - 1.25% kernfs_iop_get_link
                         down_read
                 - 1.25% may_open
                      inode_permission
                      __inode_permission
                      kernfs_iop_permission
                      down_read
                 - 1.20% lookup_fast
                      d_revalidate.part.24
                      kernfs_dop_revalidate
                      down_read
	-   28.96%    28.83%  showgids     [kernel.kallsyms]       [k] up_read
             28.83% __libc_start_main
                __open_nocancel
                entry_SYSCALL_64_after_hwframe
                do_syscall_64
                sys_open
                do_sys_open
                do_filp_open
              - path_openat
                 - 28.42% link_path_walk
                    - 18.09% inode_permission
                       - __inode_permission
                          - 18.07% kernfs_iop_permission
                               up_read
                    - 9.08% walk_component
                         lookup_fast
                       - d_revalidate.part.24
                          - 9.08% kernfs_dop_revalidate
                               up_read
                    - 1.25% kernfs_iop_get_link

In the above snippet down_read/up_read of kernfs_rwsem is taking ~68% of CPU. We
also know that cache line bouncing for kernfs_rwsem is major contributor towards
this overhead because as per [2], changing kernfs_rwsem to a per-cpu
kernfs_rwsem reduced this to a large extent.

Now kernfs_iop_permission is taking kernfs_rwsem to access inode attributes
which are not accessed in kernfs_dop_revalidate (the other path contending for
kernfs_rwsem). So if we use a separate rwsem for protecting inode attributes we
can see that contention towards kernfs_rwsem greatly reduces. For example using
a global rwsem (kernfs_iattr_rwsem) to protect inode attributes as per following
patch:

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 6acd9c3d4cff..f185427131f9 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -757,11 +757,13 @@ int kernfs_add_one(struct kernfs_node *kn)
                goto out_unlock;

        /* Update timestamps on the parent */
+       down_write(&root->kernfs_iattr_rwsem);
        ps_iattr = parent->iattr;
        if (ps_iattr) {
                ktime_get_real_ts64(&ps_iattr->ia_ctime);
                ps_iattr->ia_mtime = ps_iattr->ia_ctime;
        }
+       up_write(&root->kernfs_iattr_rwsem);

        up_write(&root->kernfs_rwsem);

@@ -1442,10 +1444,12 @@ static void __kernfs_remove(struct kernfs_node *kn)
                                pos->parent ? pos->parent->iattr : NULL;

                        /* update timestamps on the parent */
+                       down_write(&root->kernfs_iattr_rwsem);
                        if (ps_iattr) {
                                ktime_get_real_ts64(&ps_iattr->ia_ctime);
                                ps_iattr->ia_mtime = ps_iattr->ia_ctime;
                        }
+                       up_write(&root->kernfs_iattr_rwsem);

                        kernfs_put(pos);
                }
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 74f3453f4639..1b8bffc6d2d3 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -101,9 +101,9 @@ int kernfs_setattr(struct kernfs_node *kn, const struct
iattr *iattr)
        int ret;
        struct kernfs_root *root = kernfs_root(kn);

-       down_write(&root->kernfs_rwsem);
+       down_write(&root->kernfs_iattr_rwsem);
        ret = __kernfs_setattr(kn, iattr);
-       up_write(&root->kernfs_rwsem);
+       up_write(&root->kernfs_iattr_rwsem);
        return ret;
 }

@@ -119,7 +119,7 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns,
struct dentry *dentry,
                return -EINVAL;

        root = kernfs_root(kn);
-       down_write(&root->kernfs_rwsem);
+       down_write(&root->kernfs_iattr_rwsem);
        error = setattr_prepare(&init_user_ns, dentry, iattr);
        if (error)
                goto out;
@@ -132,7 +132,7 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns,
struct dentry *dentry,
        setattr_copy(&init_user_ns, inode, iattr);

 out:
-       up_write(&root->kernfs_rwsem);
+       up_write(&root->kernfs_iattr_rwsem);
        return error;
 }
@@ -189,10 +189,10 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
        struct kernfs_node *kn = inode->i_private;
        struct kernfs_root *root = kernfs_root(kn);

-       down_read(&root->kernfs_rwsem);
+       down_read(&root->kernfs_iattr_rwsem);
        kernfs_refresh_inode(kn, inode);
        generic_fillattr(&init_user_ns, inode, stat);
-       up_read(&root->kernfs_rwsem);
+       up_read(&root->kernfs_iattr_rwsem);

        return 0;
 }

@@ -285,10 +285,10 @@ int kernfs_iop_permission(struct user_namespace *mnt_userns,
        kn = inode->i_private;
        root = kernfs_root(kn);

-       down_read(&root->kernfs_rwsem);
+       down_read(&root->kernfs_iattr_rwsem);
        kernfs_refresh_inode(kn, inode);
        ret = generic_permission(&init_user_ns, inode, mask);
-       up_read(&root->kernfs_rwsem);
+       up_read(&root->kernfs_iattr_rwsem);

        return ret;
 }

diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index fc5821effd97..4620b74f44b0 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -47,6 +47,7 @@ struct kernfs_root {

        wait_queue_head_t       deactivate_waitq;
        struct rw_semaphore     kernfs_rwsem;
+       struct rw_semaphore     kernfs_iattr_rwsem;
 };



greatly reduces the CPU usage seen earlier in down_read/up_read:


 -   13.08%    13.02%  showgids       [kernel.kallsyms]       [k] down_read
             13.02% __libc_start_main
                __open_nocancel
                entry_SYSCALL_64_after_hwframe
                do_syscall_64
                sys_open
                do_sys_open
                do_filp_open
              - path_openat
                 - 12.18% link_path_walk
                    - 9.44% inode_permission
                       - __inode_permission
                          - 9.43% kernfs_iop_permission
                               down_read
                    - 2.53% walk_component
                         lookup_fast
                         d_revalidate.part.24
                         kernfs_dop_revalidate
                         down_read
                 + 0.62% may_open
        -   13.03%    12.97%  showgids       [kernel.kallsyms]      [k] up_read
             12.97% __libc_start_main
                __open_nocancel
                entry_SYSCALL_64_after_hwframe
                do_syscall_64
                sys_open
                do_sys_open
                do_filp_open
              - path_openat
                 - 12.86% link_path_walk
                    - 11.55% inode_permission
                       - __inode_permission
                          - 11.54% kernfs_iop_permission
                               up_read
                    - 1.06% walk_component
                         lookup_fast
                       - d_revalidate.part.24
                          - 1.06% kernfs_dop_revalidate

As can be seen down_read/up_read CPU usage is ~26% (compared to ~68% of default
case).

Further using a hashed rwsem for protecting inode attributes as per following patch:

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 6acd9c3d4cff..dfc0d2167d86 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -734,6 +734,7 @@ int kernfs_add_one(struct kernfs_node *kn)
        struct kernfs_iattrs *ps_iattr;
        bool has_ns;
        int ret;
+       struct rw_semaphore *rwsem;

        down_write(&root->kernfs_rwsem);

@@ -757,11 +758,13 @@ int kernfs_add_one(struct kernfs_node *kn)
                goto out_unlock;

        /* Update timestamps on the parent */
+       rwsem = kernfs_iattr_down_write(kn);
        ps_iattr = parent->iattr;
        if (ps_iattr) {
                ktime_get_real_ts64(&ps_iattr->ia_ctime);
                ps_iattr->ia_mtime = ps_iattr->ia_ctime;
        }
+       kernfs_iattr_up_write(rwsem, kn);

        up_write(&root->kernfs_rwsem);

@@ -1443,8 +1446,10 @@ static void __kernfs_remove(struct kernfs_node *kn)

                        /* update timestamps on the parent */
                        if (ps_iattr) {
+                               struct rw_semaphore *rwsem =
kernfs_iattr_down_write(pos->parent);
                                ktime_get_real_ts64(&ps_iattr->ia_ctime);
                                ps_iattr->ia_mtime = ps_iattr->ia_ctime;
+                               kernfs_iattr_up_write(rwsem, kn);
                        }

                        kernfs_put(pos);
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 74f3453f4639..2b3cd5a9464f 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -99,11 +99,12 @@ int __kernfs_setattr(struct kernfs_node *kn, const struct
iattr *iattr)
 int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 {
        int ret;
+       struct rw_semaphore *rwsem;
        struct kernfs_root *root = kernfs_root(kn);

-       down_write(&root->kernfs_rwsem);
+       rwsem = kernfs_iattr_down_write(kn);
        ret = __kernfs_setattr(kn, iattr);
-       up_write(&root->kernfs_rwsem);
+       kernfs_iattr_up_write(rwsem, kn);
        return ret;
 }

@@ -114,12 +115,13 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns,
struct dentry *dentry,
        struct kernfs_node *kn = inode->i_private;
        struct kernfs_root *root;
        int error;
+       struct rw_semaphore *rwsem;

        if (!kn)
                return -EINVAL;

        root = kernfs_root(kn);
-       down_write(&root->kernfs_rwsem);
+       rwsem = kernfs_iattr_down_write(kn);
        error = setattr_prepare(&init_user_ns, dentry, iattr);
        if (error)
                goto out;
@@ -132,7 +134,7 @@ int kernfs_iop_setattr(struct user_namespace *mnt_userns,
struct dentry *dentry,
        setattr_copy(&init_user_ns, inode, iattr);

 out:
-       up_write(&root->kernfs_rwsem);
+       kernfs_iattr_up_write(rwsem, kn);
        return error;
 }

@@ -188,11 +190,12 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
        struct inode *inode = d_inode(path->dentry);
        struct kernfs_node *kn = inode->i_private;
        struct kernfs_root *root = kernfs_root(kn);
+       struct rw_semaphore *rwsem;

-       down_read(&root->kernfs_rwsem);
+       rwsem = kernfs_iattr_down_read(kn);
        kernfs_refresh_inode(kn, inode);
        generic_fillattr(&init_user_ns, inode, stat);
-       up_read(&root->kernfs_rwsem);
+       kernfs_iattr_up_read(rwsem, kn);

        return 0;
 }
@@ -278,6 +281,7 @@ int kernfs_iop_permission(struct user_namespace *mnt_userns,
        struct kernfs_node *kn;
        struct kernfs_root *root;
        int ret;
+       struct rw_semaphore *rwsem;

        if (mask & MAY_NOT_BLOCK)
                return -ECHILD;
@@ -285,10 +289,10 @@ int kernfs_iop_permission(struct user_namespace *mnt_userns,
        kn = inode->i_private;
        root = kernfs_root(kn);

-       down_read(&root->kernfs_rwsem);
+       rwsem = kernfs_iattr_down_read(kn);
        kernfs_refresh_inode(kn, inode);
        ret = generic_permission(&init_user_ns, inode, mask);
-       up_read(&root->kernfs_rwsem);
+       kernfs_iattr_up_read(rwsem, kn);

        return ret;
 }
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index fc5821effd97..bd1ecd126395 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -169,4 +169,53 @@ extern const struct inode_operations kernfs_symlink_iops;
  * kernfs locks
  */
 extern struct kernfs_global_locks *kernfs_locks;
+
+static inline struct rw_semaphore *kernfs_iattr_rwsem_ptr(struct kernfs_node *kn)
+{
+       int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+
+       return &kernfs_locks->iattr_rwsem[idx];
+}
+
+static inline struct rw_semaphore *kernfs_iattr_down_write(struct kernfs_node *kn)
+{
+       struct rw_semaphore *rwsem;
+
+       kernfs_get(kn);
+
+       rwsem = kernfs_iattr_rwsem_ptr(kn);
+
+       down_write(rwsem);
+
+       return rwsem;
+}
+
+static inline void kernfs_iattr_up_write(struct rw_semaphore *rwsem,
+                                        struct kernfs_node *kn)
+{
+       up_write(rwsem);
+
+       kernfs_put(kn);
+}
+
+
+static inline struct rw_semaphore *kernfs_iattr_down_read(struct kernfs_node *kn)
+{
+       struct rw_semaphore *rwsem;
+
+       kernfs_get(kn);
+
+       rwsem = kernfs_iattr_rwsem_ptr(kn);
+
+       down_read(rwsem);
+
+       return rwsem;
+}
+
+static inline void kernfs_iattr_up_read(struct rw_semaphore *rwsem,
+                                       struct kernfs_node *kn)
+{
+       up_read(rwsem);
+
+       kernfs_put(kn);
+}
 #endif /* __KERNFS_INTERNAL_H */
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index d0859f72d2d6..f282e5d65d04 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -392,8 +392,10 @@ static void __init kernfs_mutex_init(void)
 {
        int count;

-       for (count = 0; count < NR_KERNFS_LOCKS; count++)
+       for (count = 0; count < NR_KERNFS_LOCKS; count++) {
                mutex_init(&kernfs_locks->open_file_mutex[count]);
+               init_rwsem(&kernfs_locks->iattr_rwsem[count]);
+       }
 }

 static void __init kernfs_lock_init(void)
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 73f5c120def8..fcbf5e7c921c 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -89,6 +89,7 @@ struct kernfs_iattrs;
  */
 struct kernfs_global_locks {
        struct mutex open_file_mutex[NR_KERNFS_LOCKS];
+       struct rw_semaphore iattr_rwsem[NR_KERNFS_LOCKS];
 };

 enum kernfs_node_type {


gives further improvement in CPU usage:

-    8.26%     8.22%  showgids         [kernel.kallsyms]       [k] down_read
             8.19% __libc_start_main
                __open_nocancel
                entry_SYSCALL_64_after_hwframe
                do_syscall_64
                sys_open
                do_sys_open
                do_filp_open
              - path_openat
                 - 7.59% link_path_walk
                    - 6.66% walk_component
                         lookup_fast
                       - d_revalidate.part.24
                          - 6.66% kernfs_dop_revalidate
                               down_read
                    - 0.71% kernfs_iop_get_link
                         down_read
                 - 0.58% lookup_fast
                      d_revalidate.part.24
                      kernfs_dop_revalidate
                      down_read
        -    7.44%     7.41%  showgids         [kernel.kallsyms]       [k] up_read
             7.39% __libc_start_main
                __open_nocancel
                entry_SYSCALL_64_after_hwframe
                do_syscall_64
                sys_open
                do_sys_open
                do_filp_open
              - path_openat
                 - 7.36% link_path_walk
                    - 6.45% walk_component
                         lookup_fast
                         d_revalidate.part.24
                         kernfs_dop_revalidate
                         up_read

In above snippet CPU usage in down_read/up_read has gone down to ~16%

So do you think that rather than replacing global kernfs_rwsem with a hashed one
, any of the above mentioned 2 patches (1. Use a global rwsem for protecting
inode attributes or 2. Use a hashed rwsem for protecting inode attributes)
can be used. These patches are not breaking code paths involving multiple nodes
that currently use global kernfs_rwsem.
With hashed kernfs_rwsem I guess there will always be a risk of some corner case
getting missed.

If any of these approaches are acceptable, I can send the patch for review along
with other changes of this series

Thanks again for reviews,
  -- Imran

[1]: https://lore.kernel.org/all/20220428055431.3826852-5-imran.f.khan@oracle.com/
[2]: https://lore.kernel.org/all/20220620032634.1103822-1-imran.f.khan@oracle.com/
