Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1FF70D389
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 08:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjEWGDH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 02:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjEWGDE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 02:03:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ECE109;
        Mon, 22 May 2023 23:03:03 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N61Wb8012382;
        Tue, 23 May 2023 06:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=RgSWfcIItn0eHaYdUzwx9rBrqicmKDb956v8WTJshrg=;
 b=vz82fs77VuqSaMjPVFEUa1X8Fo1CUVzKgZuFOIa+pZNMMoqYrfLXh8QmZZzESoEi4lAl
 1i8u7tKZU/O5xLzhgr9jwXLthHiqm1D2JauPNwGIFEAnqZy4XE3Bld9v7usIJtGBwqUU
 lqdSelueQSLaY66Ut04QS1VEpXn0tvrACA02MQdJsez2wanVMP7epeR57IwObL4mi/uz
 nKTTprONlgPkbX+yRjo898Isvh+saMWRFdpSgCQCajlfywshUr2uscgdiBrv7/ysoY6d
 tQGEp8cOft5dlorGEwyhvUZRvD+Py0i9QmED9EZ3C8pxqQrTCN0Jei0ghumZiWtYpd/v pw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpprtm8sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 06:02:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34N4nmKS028688;
        Tue, 23 May 2023 06:02:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2qm4n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 06:02:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1h5m3DClMgK4q4bWV5tN0mmCl0xAXufUXi9SFYORgszF2VqPF7U8Ph5XDS54Tv0ygp8/dAubjHoQasLAFNH3D+wFHaUoO+Knku3euZtCumi8RWHVsye2Z7kF3ygdHtiWVs9I8NZGoA4CCjsLaNu5lFI6ULc1F2T3AN3UkD7CwXyCwsjEitUgYl0fAxDOd1wfrYbX0FS7qj5rMxttBPxbLJDvxHHyLvF5idlyt8i4jZxz4x3hyBonelm5OXIYI5zsCb5R/pJu50/c+nUroBDpcmgWaD0Czp7i0c7fXx/S5dvJ1jLiqNRVdwTAprsI30L4H1n1Ts2DtBcxBc4G4c9MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgSWfcIItn0eHaYdUzwx9rBrqicmKDb956v8WTJshrg=;
 b=gzh4eZZ+P6xUXVa3j9q4toDQfrqaK1BH1FANu33QC80r796lmJ88BtAXMtOuQyJUMkM787IslDSiByMF1mD4dfihHDSLimoMpzg4LDPZNHasCfk8Hm19txQMyEBBkGEyVQK4cz8681IipkfKDJuSeH5JuyFXA0YQsG5Uk3C0TqGo2iYBqqxOdP+LF2ZRAqEBHTKQKOUsYvLihFHmX1dLUclZcmY9UCBP20Z7/CtUPk3zWmh58YwmWbJAjTgRHe1p+R6tcSUyTfDOL2Srk8dijRapxcK/aT8XPCPdRRW5hmwyPk9EHCXG8tGvJWb//pJXt/V0qmoDACJZuFBpoCATRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgSWfcIItn0eHaYdUzwx9rBrqicmKDb956v8WTJshrg=;
 b=Lk5kSRdrZ3MrUkf7gEjRzRA8XOGhx3DJxj/Wjs2WBHQebuPuWJdHsnEDJCXyoFdibY9fETZbUk18s/QpOl5bpaKr5hRfheEr1ikM/2yv3blrwpwS94eb4rZ+38lv51e399LxieGoBbc7m0YRGCNWNd4b+kIC494Verhdt/XP5oA=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by DS7PR10MB5024.namprd10.prod.outlook.com (2603:10b6:5:3a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 06:02:52 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841%7]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 06:02:52 +0000
Message-ID: <4eda21d1-bc9c-ae1e-009b-c868dd18abce@oracle.com>
Date:   Mon, 22 May 2023 23:02:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v5 2/3] NFSD: handle GETATTR conflict with write
 delegation
To:     Chuck Lever <cel@kernel.org>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1684799560-31663-1-git-send-email-dai.ngo@oracle.com>
 <1684799560-31663-3-git-send-email-dai.ngo@oracle.com>
 <ZGwoXtYZP0Z0JgAf@manet.1015granger.net>
Content-Language: en-US
From:   dai.ngo@oracle.com
In-Reply-To: <ZGwoXtYZP0Z0JgAf@manet.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0104.namprd13.prod.outlook.com
 (2603:10b6:806:24::19) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|DS7PR10MB5024:EE_
X-MS-Office365-Filtering-Correlation-Id: e6598ad9-da52-4b87-d126-08db5b5357dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pg2zDdbeUMldLW68RhPFErjJeNHYZZWmwJfYNLRqwvUNxUOaTUxlBmSNE2NFcNc1rjGumFnh0gHOiw3e1DzHhyAc+t+LIOwpZm8OgBt0FeugBoIdoPsILdj39Sa5qmAWI6neaFWOkKKkvXgdUiIbOv8NX/qH+HaszyvW7PT8GBp4zUPgLTEIJ400AyaMNRF/8q24G1Rpb1kJu2DXu3zTxTEbzRxZLHmhPXGQn0tJ/T+cUK4sjHJVHPWJzYSj2TqYVG3jYo/RhIi910uTWjG2TX0bwSA+/WJRcr1t8Wf8KABJF5dq1w9TZJZHGWrjBxXVcZYG9Gv+VGfD8Imo/1iKPZHbDaHSFU6EyK5bbhFr/SBz7OURcjBK8FgWVbPfEb0gT3HFbdADR44Ndyz04iMdgTE5KjbDL0Dxomcppn9eLaBq902tR8sGtF9zqLh8rajC1c2ZcNTZtIp4/sFkKVi2p8eIGIqIdlwNIAuaRuD6lH6FEvvT1IE0QNrVKYy7XBrRNyma53VH51YD/cD05IU/kJC45jlhAv0HhN82B/dVWbsvTbapUgR4H5PnSWIQfXZRm+RnCfRX2FWEy5sML6ezzYt81OqUXmuX7KTj6Gfq1mvRrJz3OfhZMDNKeRMGcadh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199021)(41300700001)(6486002)(6666004)(316002)(26005)(9686003)(53546011)(6506007)(6512007)(8936002)(8676002)(5660300002)(36756003)(38100700002)(478600001)(31696002)(2616005)(86362001)(83380400001)(31686004)(2906002)(186003)(6916009)(66556008)(66476007)(66946007)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWV2TGU5enEvUEdCVXl0Zk9PS05RdmdvMXlxS1lFWTdIZUQ1VmthUzVNK3RC?=
 =?utf-8?B?NzV2aVNuTDJ1ekY0aW9rTzZJQXpsOHBkTlVVUVNiV1dVOEIzdzB6b1dSOG9I?=
 =?utf-8?B?SzZRTlhMWkxQVm96enpRUkxVQzlUeFkzMG1CN0NUZ0sxbTFDQWhIS1ZYM1Iw?=
 =?utf-8?B?Mi8yK0k3RFNnVG5XWlRFZE1UbHRsK1BxN0JCVjk5WldsR3BOemJIVUFYZFl2?=
 =?utf-8?B?WXExYk9BUTV6bERxelR6V01qa0xNSzRNZ2xWOXkzT2h1SlRhcCs3bzZKVXRP?=
 =?utf-8?B?T1BNM2FRbCtnQzh0dWIzWHlBa0x5Sncwclk1dDgwMmt3cFc4UjJHVVFRM3Qv?=
 =?utf-8?B?SW9KUnJUbFFXdFQ1WFl5aVFHZjdhaXQ4ZUR5TFpuZG5wRkdNMnVmVTJjUTU1?=
 =?utf-8?B?Nkc4UjNnazJUaEVSQ3JWemZ2OEZYVDhUbndFK2h5Vm53Um1ZbnZ5ZHVBb0Jn?=
 =?utf-8?B?TjR3QXUvd0NvQ3RQcnlIejJ0cG9LN0p4cDNtcWlxbmZmRHhZeDZXeGhyT3N5?=
 =?utf-8?B?OHJUMlNZNEdUeDB0RlFPLzlpTDRzejIrYmp3M3FjdFJkb2NIVVRkbERBdERx?=
 =?utf-8?B?VkxBa1lTOTZTNHVrNkozamk2M3hGd0Nic0xDWXEwcmN4VTlCVWlhU0UxOXZa?=
 =?utf-8?B?V29FbURqTzJKZU1xeUZmalJaM1BDTDNkeGppbzFUa3VqcS9tSGdvVnVVYWth?=
 =?utf-8?B?NHBYekxSa0g2Z1lCb1F3Tk00R3JxZzE3cDJaQmIyRnlHUUg2SGlndDIvZjBm?=
 =?utf-8?B?U3B5ZDNGN1FOdHpnZmpIQXlDTjVVblVoUXBkTFo0L0hJS2RNT0poNVRhdjlr?=
 =?utf-8?B?RUFsVUxOeTArOHhxT2ptZjN2SUtNMDFJcHpKclkrQWdtdUpPSm5OazdnQ3dX?=
 =?utf-8?B?RndDaW1QWExHRHVZK0ZNTXBPZ25zMEhKOTRFVEtxYmlxelZrUUlWNTU3Y0ZE?=
 =?utf-8?B?UHZWaHMzY1JXU08rT0xkMCtrdnpLaFBXcDJuL3NjZWFHcGlQMHpRem4zQ1pC?=
 =?utf-8?B?azQ3WnhsMysrSDZia2RTcDBRM1ZqbzNrL042aEhkbDhXY2lWY3dsQzdwSkpG?=
 =?utf-8?B?L0xqZkVtcUVCQUhwK2xaVjJRUEp1b3RBSGpydXV4TWpYL2ZaUU9YNWN5MXlH?=
 =?utf-8?B?eTBwbmlQU2VkZDl6ZmtlM1doN29nVDlqYkEvU3FqNENxdzdlbXFjMkgrdE5L?=
 =?utf-8?B?UlFtUk16L0psdHlUQlVlSVExRWJKS2xKWkJJbHJEQnIrNlhsZlVPUnBRa284?=
 =?utf-8?B?QUNaWjYzMVU0cUJuZkNBQXRJR3BrbGFHK2k0dlo4SU9JeW81Njd0dVM2SUtw?=
 =?utf-8?B?cTBkZmpGaURpb0RaalIzZ1NGQXZVZnd4cXAwMVE5N0NkRFlxOERXcWwvbjhH?=
 =?utf-8?B?QkZzbjNDcC9WQzRwUE10cU80dWU1WE8vV0JCajhiNmdwRWRvdmYvQlVhNy9r?=
 =?utf-8?B?RUNWTVFDMWpOaEo0c2dQcDNjT3E0MXpiM2o0SXdmQkNqQkFJdTNIcVJERk1Q?=
 =?utf-8?B?ZTk0c1A4UzlIVWphNTFXcTZpZml0cTNXeTF3YUtxRElQdzBiYm5DTE1WTWMz?=
 =?utf-8?B?TGdxUXBETlNPaW9yMGtOU1NQaVlFZjROMWlNVzJ1OFd3YXFYUm1Hc09WRFhU?=
 =?utf-8?B?eGRpZHAydkZKczZXOWdWNC9EVVo4eXMxQmlLQUpyVUVDbmpJaVBMZ1grdDJt?=
 =?utf-8?B?SFN0b1BDSk1qV3l1YlJPZXQ2cUlvckUzdnVybkNyRlJLMkc5aUhvc2RRRXpm?=
 =?utf-8?B?YkoyK28rVGIrNmNwQjM0OUY2R1FaTmtMZ3hialZGdTBvYkgrUEpCR3RpblVn?=
 =?utf-8?B?MjI3VzllY0YrOThhZFZMa0xpcEdEUUlaenVRWE05eWNqU1NYcXZMZGlZT1VX?=
 =?utf-8?B?Y2dVSzdUbU9rUnNGRWRqK2V3ZFVKOEgyTWlEbDg3dHdlQWpLUXJKUHg3OGRE?=
 =?utf-8?B?Yi9ndGNtM1AydEs0TDR6MjBhYlVMOEpoMWdPR20xSnZTektsR3Arb0ZWanc3?=
 =?utf-8?B?RkVmL2U5NUtPOGh6UHZHc1MycGJwNmhNYWN4Ty9PYlF0d2FVd1dyT2hob01N?=
 =?utf-8?B?SXo3cG9LMUdFZjZGT3BNMVpvNlgwZEVJRjE4WStPUyt4RjVoZWlma3h2ODQ4?=
 =?utf-8?Q?lT9T5fGcNj4nNb7Aq/AUN8TqZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NvtfCXMwlZmfBJ+1gynDxuILuyY+TbD73kjiTMp15eDLEhWPd7qteJg8A7sNO1/U5rPqoEjlFAe8A2Iva97O37z2rD3/18mdu/F4DXkN9pRYu8Jo4rQENbog1vdYm4Qq2litX3uMjXb/U4VKQg8oVdnw/4xhTHlsmQzTqJmfiFCqcnpOTFnFmehZS/+IgM8JuKDC1YHCoQnI8ulKyuNaH2S/kU9torKLJ8mgfegrnQ1Ea7IsbkYcRB658XsskGTmEoVzzG/dr5E7AN7vn+OSDUnZb6mXfuBtuJNsi45Uc1pwgetqPiWH1K59b15vyNuhIINeFshdAOu/b1yqVRTvR0WE7MfeNaMzPvcR8LJyGKMq1Ld8+d7Zk2zhK8kKcAFiiqgh9KNnYxYxq/qZFO8/w3HuZ66lnA/3m8U9i8fc33FC/aGpCI2F8Hf6IBdZo/xdgPY4HV1DHOtc8hw6G95gG6xHVkUS0vp2DHJn9d4K7766H1GBNJ9yNROCLkVPgL8CB5baZoY8BvC3yvA+wh3lF1un87wC+ZYElu7D8VsmaT/ZlWC8qqwrhq4uGiOeCvROjyV9yy0RoNn0yMJ3OUJdQJjidXVODGfWJUvjdXyudDxJOU1MmjiwKRob4hWEZolOGzSR5nN9Qn+BRUJYtlnT7qnK2SKMSVtUU6a973a5Sb3zZRURSjuAdQAwaJ6Mf9os+REEmSZ5JgT/EVFYAPUu2Ug+v73jqr7vvyu4306bXW46FzcpOmRS16Q/UYVA+2X1PA4U1t10Si3Ktna74CKPWDKWxXjZdo1f/0cRZsot/Us=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6598ad9-da52-4b87-d126-08db5b5357dc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 06:02:51.9249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2e5WUZLD2JcZI/1vep+K3xeDpCXvi4e+XN07vwTN96h4Sol0A78pWcKvKu3WPHFjjQ1W0RQHGnVUAFzp7G3rCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5024
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_03,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230048
X-Proofpoint-GUID: lmry1yauJD7W1jzF2krgrsFGb2l0v6c-
X-Proofpoint-ORIG-GUID: lmry1yauJD7W1jzF2krgrsFGb2l0v6c-
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/22/23 7:43 PM, Chuck Lever wrote:
> On Mon, May 22, 2023 at 04:52:39PM -0700, Dai Ngo wrote:
>> If the GETATTR request on a file that has write delegation in effect
>> and the request attributes include the change info and size attribute
>> then the write delegation is recalled and NFS4ERR_DELAY is returned
>> for the GETATTR.
> Isn't this yet another case where the server should send the
> CB_RECALL and wait for it briefly, before resorting to
> NFS4ERR_DELAY?

Think about this more, I don't think we even need to recall the
delegation at all. The Linux client does not flush the dirty file
data before returning the delegation so the GETATTR still get stale
attributes at the server. And the spec is not explicitly requires
the delegation to be recalled.

If we want to provide the client with more accurate file attributes
then we need to use the CB_GETATTR to get the up-to-date change info
and file size from the client. I think we agreed to defer this for later.

>
>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 37 +++++++++++++++++++++++++++++++++++++
>>   fs/nfsd/nfs4xdr.c   |  5 +++++
>>   fs/nfsd/state.h     |  3 +++
>>   3 files changed, 45 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index b90b74a5e66e..ea9cd781db5f 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -8353,3 +8353,40 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
>>   {
>>   	get_stateid(cstate, &u->write.wr_stateid);
>>   }
>> +
>> +__be32
>> +nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp, struct inode *inode)

need to change this function name to nfsd4_deleg_getattr_conflict.

> As a globally-visible function, this needs a documenting comment, and
> please use "nfsd4_" rather than "nfs4_".

will fix, if we decide to do the recall.

-Dai

>
>
>> +{
>> +	struct file_lock_context *ctx;
>> +	struct file_lock *fl;
>> +	struct nfs4_delegation *dp;
>> +
>> +	ctx = locks_inode_context(inode);
>> +	if (!ctx)
>> +		return 0;
>> +	spin_lock(&ctx->flc_lock);
>> +	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
>> +		if (fl->fl_flags == FL_LAYOUT ||
>> +				fl->fl_lmops != &nfsd_lease_mng_ops)
>> +			continue;
>> +		if (fl->fl_type == F_WRLCK) {
>> +			dp = fl->fl_owner;
>> +			/*
>> +			 * increment the sc_count to prevent the delegation to
>> +			 * be freed while sending the CB_RECALL. The refcount is
>> +			 * decremented by nfs4_put_stid in nfsd4_cb_recall_release
>> +			 * after the request was sent.
>> +			 */
>> +			if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker) ||
>> +					!refcount_inc_not_zero(&dp->dl_stid.sc_count)) {
>> +				spin_unlock(&ctx->flc_lock);
>> +				return 0;
>> +			}
>> +			spin_unlock(&ctx->flc_lock);
>> +			return nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
>> +		}
>> +		break;
>> +	}
>> +	spin_unlock(&ctx->flc_lock);
>> +	return 0;
>> +}
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index 76db2fe29624..ed09b575afac 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -2966,6 +2966,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>>   		if (status)
>>   			goto out;
>>   	}
>> +	if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
>> +		status = nfs4_handle_wrdeleg_conflict(rqstp, d_inode(dentry));
>> +		if (status)
>> +			goto out;
>> +	}
>>   
>>   	err = vfs_getattr(&path, &stat,
>>   			  STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index d49d3060ed4f..64727a39f0db 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -732,4 +732,7 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
>>   	cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
>>   	return clp->cl_state == NFSD4_EXPIRABLE;
>>   }
>> +
>> +extern __be32 nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp,
>> +				struct inode *inode);
>>   #endif   /* NFSD4_STATE_H */
>> -- 
>> 2.9.5
>>
