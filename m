Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC98500328
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 02:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239175AbiDNAuX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 20:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236286AbiDNAuV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 20:50:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145F133EA1;
        Wed, 13 Apr 2022 17:47:57 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23DMRAPN032238;
        Thu, 14 Apr 2022 00:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YHOriQf0mvBmr9B8YiM7HmsKzMcVlYjjJAcIkJIeu/w=;
 b=EC1itVWItEau+N9ubZosYsHFWecF8S3JgCryoTMIiSan3qtiknurR4vAe0Q9YKGDp4PD
 vEB3fGA3VhwrJvp57BZ5SxVt2JVJxT9CYh1xxvhzTZOFl8raNE8SNZRTNmQ9JIXRlpQJ
 j3n32oJsUsEddnX1RIYyMBnNLhCPiK9RF1X3tTj4DB+Qkzh/aB3jNJBL31znYnHQXaM6
 JU4+Ff6RUOhbdKIKRn0PCqjjTWkizdi0uDNof3nyVWcEQ36yu2t9Dcngn20Amttafk3N
 8QW0/Js298Hcb7i6+yCDobkT8t2jSrm8J1mdzngamomqZ5VzRAK5uEbQogZHm5KmhLfY cA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0jdb56d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 00:47:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23E0jpmI040354;
        Thu, 14 Apr 2022 00:47:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k4s3cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 00:47:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5TNJqRgnwMEZqAZuPK2AhdoflAVvysQVruGbWrW0ESImXAy0KcD1vWBiSiB32+E3zpXk8Exzvf6dGg/lKAPvKgBxeDL8iDJGYbU5q/huTPyHMQRwiQCrW+Zvx0ClGxdpbeQr5sxcUVnm8gLcoA18CopNSvrE84O+DMoPDWbWkKK2H6Nl0OhG9qsM+jz9zF/2Bp8urUtfycGSQpfGhzcoAHbXie+wnV7HeS0Z7PfRQfjHKDEuVbQyNg9uEAyZr6InaVQZ9uUI7ukZUREOChNWmc51a6zcVtpG6NyIFr1ADCTMxS1r7lrUGGIv+i7q+66SpKc7va/bk7BfsnTMRH62g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHOriQf0mvBmr9B8YiM7HmsKzMcVlYjjJAcIkJIeu/w=;
 b=BFdKZsypnmv3DDaT+mYZliAtcu/hZabAA0aEpd+sdhWXxx9PmO3YHWXWb/butE5q6R+yJhThi8uqRrWAG+R4f3aXpzO146P4KKgbb2LHeL3pPAX/Jf4opjtJ+oalFXd0k8dny9UhPQthOwLzJa+Ysk3IxyqciyVXTXZGsVPdNUrNIUK+H0FAo6mBhewV+LQ53aZ3uJasstpeBXOM9wQ60/GSAyLA6SKz2x/5MWWC5Nc+NMFLMKtwQy7PwZzFXQx61FCpXU9R6kCuMUsfsHhrtp5OEWlzQ+GXOweK8YgWHMyLYlfiYihvW5qRQUWx4zQOaVwUZFEvnczSsoh5FfRsgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHOriQf0mvBmr9B8YiM7HmsKzMcVlYjjJAcIkJIeu/w=;
 b=UyjeUjz2F+q5fuqjyIOUyUJx5qIxFXA4OdgEKj8wpi/d91HCqGLgzj3SU6+Ra1ZOmms+pMy8PTTRUqQ4bDipgsHCKUyy+YnGDE+xisIs/5nslVwe5AQiXL8+QCL3QVRj/qbe7Gy35LY9Wvt/+rtdwUeSK3Zjbvg0VC2/aRR+yaA=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by PH0PR10MB4405.namprd10.prod.outlook.com (2603:10b6:510:40::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 00:47:35 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5144.029; Thu, 14 Apr 2022
 00:47:34 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v7 4/6] dax: add DAX_RECOVERY flag and .recovery_write
 dev_pgmap_ops
Thread-Topic: [PATCH v7 4/6] dax: add DAX_RECOVERY flag and .recovery_write
 dev_pgmap_ops
Thread-Index: AQHYSSYdGKTdETDbkEmdZR/SZY7Ic6ziWZ4AgADMqgCAAMiFgIAKsVwA
Date:   Thu, 14 Apr 2022 00:47:34 +0000
Message-ID: <65a3e761-d88e-a8dc-d174-29fdc6953b2b@oracle.com>
References: <20220405194747.2386619-1-jane.chu@oracle.com>
 <20220405194747.2386619-5-jane.chu@oracle.com>
 <Yk0i/pODntZ7lbDo@infradead.org>
 <196d51a3-b3cc-02ae-0d7d-ee6fbb4d50e4@oracle.com>
 <Yk52415cnFa39qil@infradead.org>
In-Reply-To: <Yk52415cnFa39qil@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 429b8166-649c-4642-d25b-08da1db05da7
x-ms-traffictypediagnostic: PH0PR10MB4405:EE_
x-microsoft-antispam-prvs: <PH0PR10MB4405110B0F044B88C2D6AED9F3EF9@PH0PR10MB4405.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N5q9gte9hNzA4BtCi7UAlI8B+3+XcW147V6zoJKThtIHFWULR8GtFpGa0X+Jo7V+YFGHrs/BpGBIMvAuQgeKvepWFYbmPizW7eewen3nvgGWLJH7aRfaxnjVjkJ1Bpfx8uCryN9o64UhwpclVLOAmZKZNwMUK75mFQ14YADPP5Bwa/YpUajGaRDTQNqAQ7VDf5SjkuXPo5rLRroMPvQH/CSVRwCqOs0xNZOsfvpdbCP9NO1l5tC7Y7RqJZLSm+XrGI59YKmlwh/HvZTPLVsgre8cAte3G3zMtnQ4C2vXCjOybdb7PXDPCW8Lt7z2IzEJcMCGXH6V/AyQWoMSdJ18/XgeBbty/c2DNO6dOKWtJFX/D0TsjeZlGALaJ7GsgxMYIPH354ZrewEfxLpYMVnvj9jFPwpveH9QelLj/oF90efJmXrFjBSGr2+kfHY7aygX6QFQ9ANeFGJ6yfHDetkY5OtnGkqfMammzhsuRuzdKYVAAvtgn7WkDahjZSHgkQ/LgJkJbg4Asdc9U5Vw2puY4nuSezTpWI8XrFAt9dg4eZob4O4rV6YjL2AjAHqXVIqKJo05fWTx4RwUug9SCMD4jN030t4c+N9b2QuZkiZu6C4hWRdjat1xASUmB5R7MXn4ZKhVxs8nECwq1FeQkxFnfFTXAF+nflJaD6P1QoTg4vAcipKz1WGoIMdnnQEjZpz6tfX55DIe3w5n4WEjvN25Tubn5xwaqORCJyz5+iT6jEFBUi/zoTw1axn+FhSPUogkBtw+ZQ3SQid4h8X+wMPGCqh+G7XvIliHuHAXuuJAkO0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(66476007)(6916009)(316002)(54906003)(508600001)(53546011)(8676002)(4326008)(44832011)(38070700005)(66946007)(122000001)(91956017)(76116006)(36756003)(31686004)(7416002)(38100700002)(64756008)(66556008)(6486002)(66446008)(71200400001)(5660300002)(26005)(6512007)(2616005)(186003)(4744005)(86362001)(6506007)(31696002)(8936002)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bU04enhCVkRyanprd056cXQ4TjArTFlxZ294NUVhUHl5dWFTL1FkOExmVklB?=
 =?utf-8?B?b1VlbjBOc3JKZm5jVkd5VGUrZlAwakRKR2k2MFp1cHc2TmQzaW0yOGVqVm5E?=
 =?utf-8?B?bDJ2c0Y1Z0lOVEhhQ0VrS3BhU1Q3ZjhSYjQvTWZlTTVCQjFZTzE2SmhwUWJC?=
 =?utf-8?B?RE5FWllBK1c4ekwxM0ltU0FMb0lzeStIclVleTRGc28yZkk1QmpSUEd3bFBW?=
 =?utf-8?B?RVdHcUpsOVB3dUR2RnlOWXovVEJLREpOL2xtNW9nbHVXek1GMFdkK3BSMXFL?=
 =?utf-8?B?cFN4L0lpditFSFVtVE5YdXVrSWZxeWlCdWxQNkFwbnZjVVZsd3VObkdTVVh1?=
 =?utf-8?B?UjFaY3dETXVpZWwwUnZjS1dsWDVGN21hOEdZakszUmlDU2tXR2ZtQ0p2TXRD?=
 =?utf-8?B?NTdYa2YzM2huYVZWWmJlNUZvMkJSdzI4ejdEeitWUEVBWEQycE4xWWcxL2c1?=
 =?utf-8?B?OGM0cU1QaHZLYzY0U0QyL3hId1BQcm54dmVITFpEMGJPOEN0K3Z2Ylc1dGQ2?=
 =?utf-8?B?RmN3NnUwaW9vWDl2eDhMWUtSbm5jK2s3SVMwaUlqRkprU1RlRXpnTGE4U29r?=
 =?utf-8?B?V1hOZVFXYzJhb0lyOUVDdW94dUNDYnBtWXd0NlYzbDNBR3VJMkk5MXBKZjFE?=
 =?utf-8?B?Nkk5OFRQTmkwVmRiVVhHOFJ5MnhWR2xRa3ZvQnl2ak0xVEhzUzZWbWNQSWxR?=
 =?utf-8?B?QmEybzU2TmtWU0RJQXI1QkVzVGRvbUdWc0dQQWNGcEw5bmFXaDZvaWI5SUJ4?=
 =?utf-8?B?alpOdXhPS2llUTVOMmRzWFJFZzgwQTdldkdvczN2VnphRjVKVjNpaGtFNnZS?=
 =?utf-8?B?M1h2aXFJNklDc0daSjdFdkx3QXhPbnN1QWVNc3dlMjJTVFQ3MkE1Zm5OWjBD?=
 =?utf-8?B?N1BPYUFRcHhVUjBTVjdEeXBCcDZLb0lzSmcvaWY5WTRTdDdiUjlaNU5CL0Nv?=
 =?utf-8?B?MU1ibHZVcU9oenVsSkJNbk9yQnBMTVRWc21rQXBoRDB2Z1Bwa3M1OW1TWSth?=
 =?utf-8?B?VEJQdG1pWHFpWjZHeDRkK2oyVXZYRTg3UElrc1d2WFF6dndHcWE0RGkyS0pu?=
 =?utf-8?B?b2xWNjU1UTJ1d29ZMEZJSk9vWjhYWEg5clZIV2lFbXVXMEFxTnhVb016M0xJ?=
 =?utf-8?B?cmpVNmlCWkVXaGJRWGJRTEtTeXA4V1d5cDVTZklJYUpQWHVma3BTRXJ6QTlm?=
 =?utf-8?B?YWZDNGlPc2wxVXkxNkVPRnZRYmxzdXU4dzJQZ3NKanM0VUZvb29TVDNEamNq?=
 =?utf-8?B?NXp4V0taWlY0cUlEL25MNzdPbTdyYm5KMjZ2L3ozY1lZcUs1NXIxM05YWWkr?=
 =?utf-8?B?TmR3dGJwU2dRL1MvdFJhT3Z1MEJBV2V4MldZczhQeEYvMTIraENqNWJQcE05?=
 =?utf-8?B?NFlxUmozZ2hVaUFPZjZjNC80U1NSZUNMVlQzb2Z4WnB5N1l5VU5IT0lubGxw?=
 =?utf-8?B?djk3SHdrWE5zT1orU1pKOXRPSDJqZFQ1YThmN2NKUHBJQ04zZ0JkZHRzRlpE?=
 =?utf-8?B?eDdVR0ZyRXNlM1A2U3pQOUozWVJWNlVTQ2NkRnFsODNjdUtHL3VnZzRndWZk?=
 =?utf-8?B?TVRkNE8vb1hpZ0p0SmNYV1Q0OUsxUlZSeXBWTElvbmUxU2Fhd3NpajhXalpl?=
 =?utf-8?B?dWpYejRZZmxRVU5JR0NTRDE1ZVR2ZlpDbHV2VFNUZnp4V2dONmo0c2RKYmFo?=
 =?utf-8?B?bmk1UDZobGdFUWhvcEZBRzBMWks3Wk9ya2hTaTBDU256WkpHOHdoUDYrZXRr?=
 =?utf-8?B?Q1FzdWUrZlhtYStkSDFZbVNweW1nMlVMcEh1SGl6SW5FdkJqN25IdlZjMm0x?=
 =?utf-8?B?QVkxdENkamJQK053eW4yR3VrNDhISDFHU3BPNTNXUmEyVWZHN0VRZUhxM3Ba?=
 =?utf-8?B?Ujl3dnNrMHhtdk9vQ01uQm1MbU1vbVVUcHpWNnFrV3hNRkJMOUpBNytuU0Jl?=
 =?utf-8?B?TFZ4R1ZVc2h1QVRFVWlwK3BnZzE0dnpyaWxVbDRCaFA1NjlDT2dwWmlHaGJi?=
 =?utf-8?B?RzlEa0FaZVhKMzdGd1d5Y1Z0THpyTGp1eitOWmF5anJUK09nUHlEVGE2Wk1L?=
 =?utf-8?B?UUxHZlR5djZJNmxZQ1UvV2wrbkI4ek11MEVBSm9rZTBRaXMyQVZSakQzZ05s?=
 =?utf-8?B?ZTF5Uy90TkJiZEVvNERtOC9KWmkwdFFEY1NHcDgrS25VTWtLaHRoY2J0UzB1?=
 =?utf-8?B?a3dNU1lWMEZxeDJZcHhNa1NJd2pJaGhYOGF0VUhEVUdGVURBVGVRUkVtaWNE?=
 =?utf-8?B?ZW96OTVBQ3RlUjRpSTBpZkdvQjhXZytQV3B4b2x1Zi9Nc0U1Y1QySXAxUlVY?=
 =?utf-8?B?b3ZHVXFkaTV6VmFadTFRSXhkeCs0TjBMVVU4Wmh5dTh1dFdGTGpBUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C43690E473AE154A97B9FC637874B7FB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 429b8166-649c-4642-d25b-08da1db05da7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 00:47:34.8138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0z93I8528PCvGVfadwJsoAShj4bg+f1P9REFjCmeR7bz/iMWKpLrdKG6F8NarpEIS6jTwv7XDI8f0y07MdUkzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4405
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-13_04:2022-04-13,2022-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=732 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204140002
X-Proofpoint-ORIG-GUID: Lf5wp0bvrKjugppJhYuX8JYu3wjWoXF3
X-Proofpoint-GUID: Lf5wp0bvrKjugppJhYuX8JYu3wjWoXF3
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC82LzIwMjIgMTA6MzAgUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBXZWQs
IEFwciAwNiwgMjAyMiBhdCAwNTozMjozMVBNICswMDAwLCBKYW5lIENodSB3cm90ZToNCj4+IFll
cywgSSBiZWxpZXZlIERhbiB3YXMgbW90aXZhdGVkIGJ5IGF2b2lkaW5nIHRoZSBkbSBkYW5jZSBh
cyBhIHJlc3VsdCBvZg0KPj4gYWRkaW5nIC5yZWNvdmVyeV93cml0ZSB0byBkYXhfb3BlcmF0aW9u
cy4NCj4+DQo+PiBJIHVuZGVyc3RhbmQgeW91ciBwb2ludCBhYm91dCAucmVjb3Zlcnlfd3JpdGUg
aXMgZGV2aWNlIHNwZWNpZmljIGFuZA0KPj4gdGh1cyBub3Qgc29tZXRoaW5nIGFwcHJvcHJpYXRl
IGZvciBkZXZpY2UgYWdub3N0aWMgb3BzLg0KPj4NCj4+IEkgY2FuIHNlZSAyIG9wdGlvbnMgc28g
ZmFyIC0NCj4+DQo+PiAxKSAgYWRkIC5yZWNvdmVyeV93cml0ZSB0byBkYXhfb3BlcmF0aW9ucyBh
bmQgZG8gdGhlIGRtIGRhbmNlIHRvIGh1bnQNCj4+IGRvd24gdG8gdGhlIGJhc2UgZGV2aWNlIHRo
YXQgYWN0dWFsbHkgcHJvdmlkZXMgdGhlIHJlY292ZXJ5IGFjdGlvbg0KPiANCj4gVGhhdCB3b3Vs
ZCBiZSBteSBwcmVmZXJlbmNlLiAgQnV0IEknbGwgd2FpdCBmb3IgRGFuIHRvIGNoaW1lIGluLg0K
DQpPa2F5Lg0KDQo+IA0KPj4gT2theSwgd2lsbCBydW4gdGhlIGNoZWNrcGF0Y2gucGwgdGVzdCBh
Z2Fpbi4NCj4gDQo+IFVuZm9ydHVudGVseSBjaGVja3BhdGNoLnBsIGlzIGJyb2tlbiBpbiB0aGF0
IHJlZ2FyZC4gIEl0IHRyZWF0cyB0aGUNCj4gZXhjZXB0aW9uIHRvIG9jY2FzaW9uYWxseSBnbyBs
b25nZXIgb3IgcmVhZGFiaWxpdHkgYXMgdGhlIGRlZmF1bHQuDQoNCkkgc2VlLg0KDQp0aGFua3Ms
DQotamFuZQ0K
