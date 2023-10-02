Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AA37B5181
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 13:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbjJBLg6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 07:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjJBLg5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:36:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59028BF;
        Mon,  2 Oct 2023 04:36:51 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3928Y7eR005262;
        Mon, 2 Oct 2023 11:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=UtTm2eGDf9lf+TZO8K0qeDpp89a70q8EhfESJH0GZjs=;
 b=y4y8LtvcQbz1amz9aOfqpaDWvl5jc5UujUBR8AaxfL6677TOMaBJ+eYFlc88KiRJ+f17
 VITKqHcZzGn1LdIQFHSgJoGoCi2YtHO1voUdXV7lpo3n972FFxXHE3sJk51XFnbvVBNa
 ArYLzuP4PCN3zwu2qXi6r74uH6NZB2MVoo4nsHR6mcfa1vhKUJgpjJ0bIhq/5YF9Omn2
 +xZoJUZmgFadfYcrxVHWvgI0LK6Q9hrgDm6p7NWsHROmBmqdcdbSzGted7ryl29flPgs
 fWTr02xm+jL9SqoElRokzIzt+NCrS9OUFYdtfag7+q4oCHsZL3h/BIYBLxtUQkLmPh/X mw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tec7va6wk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Oct 2023 11:36:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 392AWJPR033717;
        Mon, 2 Oct 2023 11:36:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea44p7s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Oct 2023 11:36:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fe/OJm91ukIIgPdWID6IltP9xwpv9fdYy8gAnEKmph9UEqPltTDtlQNUjS3xRe4hTlbVP+j+ukg/Z1yTpCVY3/cURcs87P8tkH35kS6ZV8d9gq1GFtyVV6RuDdG/8jwQSxpsgzn9xjXlS7ERNymptttTMVfL8/ra6PvqRJBpuvX3zynTLIIaMTHM4XuFmpHE3/gOOcnmgdx9Fz8JQqbTR1XSavfmc+Y8XQH7dXfXH9kPMb6+nMwbykmjfBJWY+chXf7iMz5afNpzZfF7A+8B9NKM5j0JHPs9rJ5IZ4xVRPerKrXLaMqzKCut13i7/mbeYxiXGcF82/tPG/XovF6U9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtTm2eGDf9lf+TZO8K0qeDpp89a70q8EhfESJH0GZjs=;
 b=d3eGH462oP16NSoM/QqacWIa4mI+kZSW4xULDe4fTmk5YOc8qjx1t/T23ey5poAwiWA9oGIBr0ArOruoxH366p+GYDXpvjk1/H2dTKugXfS+Y+wglvzvTqveRkhI2AY2PGZ1MozcvEtgBqkwndsOmjwmcsnLhmxrqGPCD/zecyVKbSr7dr54mTa02LXSYkoZVG8taLQjLoHFNtqryoZm4doUE0uHql+8/nrEuMbfmQ9VwO67rCetswzMl4d0YMNccWk4w5aUiJkcB2ZrPSAbh+kK9iT362PZO2eQ0exwtJeZEjoN5URvl1JeQBamFigN6tplek0KaHixU8nB+M74Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtTm2eGDf9lf+TZO8K0qeDpp89a70q8EhfESJH0GZjs=;
 b=AOABkvb2Dxy69WTv7uZqeYRmIUkF0b7xGtgMRSOGzR/tRapkX0JICaubN/E+E2T5jR0c0ie1vSzpSNWd4ZC2OdPB3xVXk+fX5q5wWYtam9QLEu9d6PUcXve+iA3z9kqlTN3HKSFR8V6+BnhEaUAf38/+Y1/lPtdP1rPeDrZXPGw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB5687.namprd10.prod.outlook.com (2603:10b6:806:23f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Mon, 2 Oct
 2023 11:36:14 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6838.030; Mon, 2 Oct 2023
 11:36:14 +0000
Message-ID: <a6041625-a203-04b3-fa42-ed023e868060@oracle.com>
Date:   Mon, 2 Oct 2023 12:36:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 19/21] scsi: sd: Add WRITE_ATOMIC_16 support
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-20-john.g.garry@oracle.com>
 <2abb1fb8-88c6-401d-b65f-b7001b2203ec@acm.org>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <2abb1fb8-88c6-401d-b65f-b7001b2203ec@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0403.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: da85e085-5304-488e-21bb-08dbc33bc876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0pyvY9WQ/giF+NliOYUMeNUPFpR6DIeR686fOsQsSFhODSKeXXM4b1sDVH+f2CwA+b01zZxm8YGEwqe6XPzc6fPoi3qJT4GfEsrY/bdZWidSaQUR8TnJQ33ZBuo9YvULbDK8+8fzg0IQ4nTe9iLQ2eb0vjA6fItHX02m3gycbCgrs/dco6jKcVyF/oIDbSxr9YLrmZpqTY3ACVP7GcraS/r1XuRf18CZyZWME6E3ElCbHSG4MmkzK8rcXlnQdTUKteMZJA31L8DklFcF2o5CniAMpamcD8pLV+CyyaDXEyfPubMSaXk2xnAHbotk+nj6jy7aWmD9lB02/Ynxfcun3vhcwXQkBYPjwefdskmp5P4p6VPF4N8dgba/eGVmYoCTd/zh97+QQAEeFdJyQH0kkzoXWRczNFoBbc0c9OkYttI77PPiizyp51WzxRSzHQYwOJGFyGMyaakbJ5udCWXQa/bf0tnjmKX9MpIpIKDsS6MYc7ptYIqdAMcpOPaR6ME69fuGB+CCtC8NZvpIj1oOlIewx1euvD00OePY7GJJKenxrP6SFi0qebenseupWAsPJ+0NSvketG14gkGxV6W4wH1GGieoZuVpVZa7E73kUBBuvP6xeV5vtC2EyDg22kyrAPVppwimbtpc27HC9BRkHAWYLwYtbsollatF/OFt7C8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(346002)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(478600001)(6666004)(83380400001)(31686004)(2616005)(26005)(921005)(6512007)(53546011)(6506007)(36916002)(6486002)(86362001)(38100700002)(2906002)(8676002)(41300700001)(4326008)(5660300002)(66946007)(66476007)(36756003)(316002)(8936002)(7416002)(66556008)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak9WSVFINCsvdDBTSy91NEdiSWNQUGZkcTNZQjFMMzhua1lNSWp4N3dXbUtU?=
 =?utf-8?B?STNwdm9mVkNXai9lMldMampPRW55Z2xhN1U5YklBY2k0ZXR4bFlNRktNMkxX?=
 =?utf-8?B?cnVQUUxGNmtHZWg1YXZVZTQ2bmZEUmZ4MjloUFZidFRpcElvMnMxa1lnMFpL?=
 =?utf-8?B?b1JNQ2N1QVVHRlNWcVhsT2ZwQk5FWHJZZmdrOWxrVmRqR1FkOEFXVys3azFj?=
 =?utf-8?B?U084U01SSm83c1JET3ZlaEx3Mm93aExXbk1kb01abFZIZy9yWE51QzJsOGJr?=
 =?utf-8?B?Sy83SzgzUmpIUHE4SUVmZDFtRDlFUDNCOFIwWHZ1NFhKRnU3UmU0YlRkNEsx?=
 =?utf-8?B?YzVPUE1kbEhibExRRXYrbU9ZeiszN2hJVElKT1oyb2ZGSXdkWm55cEtJZ1Iz?=
 =?utf-8?B?TnlkRVpLOWRud0JLcmJqa0dNTUtmbzdCLzdpZkQybzFnelZDc3MvU3ErdXFL?=
 =?utf-8?B?U3VXTDNNYmIyS2taYkEvOWd4cUNLaGtxdFhvalFlT0JrYVRlcUxLQlFWd0VG?=
 =?utf-8?B?dnRzWEk0bjNTaCtWUmYxVDdhUkhWellzMWI2UHBlVmpCTzdOZ1VPRGdLSVBj?=
 =?utf-8?B?RzVFTWlLdTRsZS9BRVpDeXA0emlwTVptc3FDdXBqSnliSnljVGgvTHQzMjhk?=
 =?utf-8?B?SktiWE12Z3gwYW9uMGcyeUE5OGx0ZS9JditjbXhtQVI5NC9ra0djU0lEVWVY?=
 =?utf-8?B?ZnY0Z2JLSXUrWnNBelpacFUxczNLWXVRUUhycEFkcHBXRUUxamVUMmRYZGc3?=
 =?utf-8?B?MGNHVlBQQytkSVRiNjJSY1RKMWpEUHEvLzU5QVdlUnNnQlVGeU5PK0srYWtN?=
 =?utf-8?B?WWFPdHJ3dkpqUlg5dUxIZjB5STdDQ0hjYnRHUjFoZ25rUDZoNVd2WVlPUGly?=
 =?utf-8?B?MUFKQlowbzFSbkZSTnR1M0dmcmRGQ2ZGbVBHMURTTkJ0LzVIQXFJZGNhVmdU?=
 =?utf-8?B?dXdlMHJOZlJ3MmNtVmJoRitvWGF1akRGUmRMRFZIRTZMakVQTjFNSnpzbSts?=
 =?utf-8?B?WG9YZStxVmgvcTQvN3FSSUg5SzY3ckxmb0JNUjMyazJ5MjFvdlZnSTFBV3ow?=
 =?utf-8?B?RDlORUwyeFZkeG41ZHV4dkdMOFZOMGhPNWtUcURDYWVmWGtYck9YNkZmanRh?=
 =?utf-8?B?YkJEY0VmMVM2UkxLWS9wYkNDeEY0VmM5STIvNEY3S21kVGs5a05VQUd3dDdG?=
 =?utf-8?B?bjNHNDZHQmRxai9sdVJmRVJXSXFubFQvL3ZObmtRcDJaUWF2Z1BHRitFMEZz?=
 =?utf-8?B?Vyt0UzNNckJJb09sRk14V01hTGphNUFEdHJCK3lrRnN6bklmWWt5NC9xQi9W?=
 =?utf-8?B?SlVRV09UQnZYVVhwb3BFOS9vMEZ0YWUrcXBGaUpLc3QySUZPWDNYWXNhZXJY?=
 =?utf-8?B?NVFYQkphZFVDQ1hLR0dYU3RIQkpsWXRJYkF0SHA3dmdqS21rQUQ4OCtCajda?=
 =?utf-8?B?WERzckx4WUJPRnZGblJ4YjByaFNMNERNYXJDeXBiMEtVbmJld25iY2ZJdkNz?=
 =?utf-8?B?V0Nzcm1wbFlhVjM3OFlTWG9yZG9iZktsTCt1N2xXS0xGOWYwWjBxMXNHaWth?=
 =?utf-8?B?MThxaVF3aFhMQmZjNUVuZ3NPWS9CdEh6VnpvYmdIRXpOZzZLaDV5T0haMTgr?=
 =?utf-8?B?RDlHSkgzT0FDeEk0OXAzWTVoUXdmZlZQTTEvNGJHdXJOT2hMb2RCSVhsVTBt?=
 =?utf-8?B?cTJNQ056dW1JZDVMUkN4R1MwVGZGaE1tMnk0QTZZcTIxV0M5Q3VrS0oxTy80?=
 =?utf-8?B?QVR0Wkg3QllRUSs2UkQ3bzN0bTZ6YXFpQS9lTTBYUmFERW5oMFd1cHN3TmdP?=
 =?utf-8?B?ZG4zS3psa3BnckEyaGRHZzZteFZ1VkdiNGI1YzUxbzdTN1pxTmsybnpGMEFh?=
 =?utf-8?B?dXh3QTU1MHBtTzFTUEZDMDArejVlTUJuRWcwSlM5alpqRlNTT0tncWZlY0or?=
 =?utf-8?B?L0hWK0hWVlQ3bFEzTFY1bGlEV2p0cWo4NzM3djM5RktsL1ZuQ21IRlVEOVNy?=
 =?utf-8?B?VzZmdS84ZDcxSFkxSlBnOTJMdVY0cVFOaTBZRWtOTzdiTkhMS1NEb1NobTR3?=
 =?utf-8?B?dis1dURBMm51Z3Vua1FqR21RSU51eVpDeExnWTd6R0NnM0hleDE5aXA4WWYx?=
 =?utf-8?Q?+Ryjpq+jt9nQv7FP8HySHLdo7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?S3hHU0p0WTVXaDNOS0RaZlpXRkRYdmFIOEh4Z1VDZCtoUmRXclNLSHpldWF3?=
 =?utf-8?B?K1o4RXZmWTFjRHlXSDhZQ0RaYk9qVkw0eXFjOEtIaGd5WThxMlNmc28ydWpK?=
 =?utf-8?B?cWNqcHlRaGNUTGNGMS9UNENlSEdVOFF1bVNLSFRPYmsxZ2pVK0RLTXRmZ1Fp?=
 =?utf-8?B?TFF3c3pPQ2VLanBqN1Z0VFo3a2xsSnFWa0hUSXdiTlIxc3kyblhhY1J4aURV?=
 =?utf-8?B?OXJpNDdDbDZwNkxIRFArc1dIZ2xwUDBTSUw0UUZkS2dsSGtmcXRGVmtFeitJ?=
 =?utf-8?B?M0ZxNEN3SDFwelZnZ1JBZUlxcU9uS0NPS0trdlZhSnhmaTJQZlAyU0RQdGJO?=
 =?utf-8?B?bzlwY3UweWdPRVJaUHhSQ0VGSnFVVHJsOGJZTi9VdnJCTUtOd3VjdzFWdisz?=
 =?utf-8?B?UHVVVTh3VVpLdkJNWDlsTkZTbmduUlBodGlFeDRZdWVTQUVkWHhJbkpVcTJr?=
 =?utf-8?B?Rzl5bFRhbTdUVnR4ekpHLzg0cU9wSVhSd2tGWk85VXM0bWdZaW04K0QvcHc0?=
 =?utf-8?B?S2NoaGl1c3hXN1g4a0hxUVhaRkdZUTc0RlQ5YTRlQmo5aW1scVpCbjRTbm5i?=
 =?utf-8?B?VW04VEFNV29sNHVKYkdmczV3ZEwyUVN1VUlhNHZPTTY4L3hLT1o1MXh3QjZN?=
 =?utf-8?B?S0RjUFdrWFRjZjNVZ25TWVMvNnNkcFQ4ZExxU2tINDBjNlNod2EvdVFsMG9y?=
 =?utf-8?B?d1c1TXdpTTlvTGozcVV3NnJReUpOQzBrYW1rMU4vYU5xaml1NTJxZit1cFdr?=
 =?utf-8?B?ZHhyTVFkZDhWOEo3M1hFdkJ2THNHYjM0MXVXdjBIdjRQMWp4RHJ3N09HQkxK?=
 =?utf-8?B?cjdjRmpTbEZGS2JaZ1g0b0dycVRlNUJONHNmbDg3UDBGQzFMUUNoN0QxcFMy?=
 =?utf-8?B?UkVSdzhYZjN6aTFUMENacEx5Y3pSMGR4dUpCNUVFTlF0bVBhNkdldGNnS3ZG?=
 =?utf-8?B?aTVBR0k1SkFrb001emJXT1I2QXBsNHVHdWlzZzhPbEJBZDJaVEJBNzVMdWN6?=
 =?utf-8?B?eWNMUW01MVd1dmlVV1h5NjlpS29PanVyejZQd3MrekYxTlNWa1RWRFZxMWRW?=
 =?utf-8?B?Zi9qKzlIb00rVjJlckc5b2V2VFZsa3M3MWUzaHFLclJTZVd3cjM5eHQwcWVr?=
 =?utf-8?B?SDA3UnBSbmsxRCs2V3dtQVZrSmdKcjh2RWIwVFZ0U0ZUaHd0bmZFdlJjdURQ?=
 =?utf-8?B?N28vOUVzL3hxNUEyNTJSYlRGZTNnenFoZmhNRXdVMmlRTFpQVmgxRlVodHJs?=
 =?utf-8?B?TGFCMGIwbWJYQmt6SEsxcE5nWVdvVnN4a3h4Y1ZvWnJWZEF5RDJwM291SFNv?=
 =?utf-8?B?cXhWVmpGaVlkSE8rTHhEOGFkYURYamdKWkR2cjdpeUl6ZUpFbTViU1h6K1hy?=
 =?utf-8?B?aW00eS9taWJzakd2c3dJL21UNEIvNGJGcG5RVzc4aEl2K0FwM2Z1c0xCaDQz?=
 =?utf-8?B?OTlmcDV6NDROSGxIK3NCRXJJYllSZXVLV2VGeGYweTd0K2ZxK0NRS2pyT0k1?=
 =?utf-8?Q?wGRpf4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da85e085-5304-488e-21bb-08dbc33bc876
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 11:36:13.8850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olYmZXh29rdv+FhOLUGOKC/8URk8KvEMNIwvz0ClJpXcFgCmme77SqKwe9uzDaTu25cKTjjjMLkc1q9Ro994kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_04,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=992
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310020086
X-Proofpoint-ORIG-GUID: p5CucFjqYwgCrJPt8pketb_KJ3qo-uin
X-Proofpoint-GUID: p5CucFjqYwgCrJPt8pketb_KJ3qo-uin
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 29/09/2023 18:59, Bart Van Assche wrote:
> On 9/29/23 03:27, John Garry wrote:
>> +static blk_status_t sd_setup_atomic_cmnd(struct scsi_cmnd *cmd,
>> +                    sector_t lba, unsigned int nr_blocks,
>> +                    unsigned char flags)
>> +{
>> +    cmd->cmd_len  = 16;
>> +    cmd->cmnd[0]  = WRITE_ATOMIC_16;
>> +    cmd->cmnd[1]  = flags;
>> +    put_unaligned_be64(lba, &cmd->cmnd[2]);
>> +    cmd->cmnd[10] = 0;
>> +    cmd->cmnd[11] = 0;
>> +    put_unaligned_be16(nr_blocks, &cmd->cmnd[12]);
>> +    cmd->cmnd[14] = 0;
>> +    cmd->cmnd[15] = 0;
>> +
>> +    return BLK_STS_OK;
>> +}
> 
> Please store the 'dld' value in the GROUP NUMBER field. See e.g.
> sd_setup_rw16_cmnd().

Are you sure that WRITE ATOMIC (16) supports dld?

> 
>> @@ -1139,6 +1156,7 @@ static blk_status_t 
>> sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>>       unsigned int nr_blocks = sectors_to_logical(sdp, 
>> blk_rq_sectors(rq));
>>       unsigned int mask = logical_to_sectors(sdp, 1) - 1;
>>       bool write = rq_data_dir(rq) == WRITE;
>> +    bool atomic_write = !!(rq->cmd_flags & REQ_ATOMIC) && write;
> 
> Please leave out the superfluous "!!".

ok, fine.

Thanks,
John
