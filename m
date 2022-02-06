Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CD74AAE6D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Feb 2022 09:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiBFI1g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Feb 2022 03:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiBFI1g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Feb 2022 03:27:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4E9C06173B;
        Sun,  6 Feb 2022 00:27:35 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2166FAw4011738;
        Sun, 6 Feb 2022 08:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wxy7ddXM5/iVz7dQM+/g/h7Sfs0xcpgmSTy3/rB54ok=;
 b=OZB6Aqw4mNI1MlD9UAhfI6iz8mfoifL3E1kD5ENkN0qyIT7hKOHVO0cTyIiE0Z2X6hHw
 z3jNC6rLCtpWxMYG/D/WRyG4LD01p7zVCxi2Ilc9JkJ8OwYRkgX8CcyQvRws82herxe1
 QxOewW8VVCaYI7DfdviOLIzSobTeFFa0CKxPDy9yFKFaiBtBYXnohcgLcUKOLxNbKWnD
 3m260y5wwe8OygMygRfJL6qhFpF7qNW9sgCFsvGWXqmjG4x7fsGnvR5T5nvVnZEO4NCn
 dUwqL3zNTb1DnicZDKFwta8irxe0E/ihwuwGKSWSM0fWo05PXZ8LCQJXi90XpCb+kDb8 Rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1hsu2r71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 08:27:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2168BeEL147451;
        Sun, 6 Feb 2022 08:27:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by userp3030.oracle.com with ESMTP id 3e1ebv4gjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 08:27:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLFUZ/tLIRulVjdeeXxVpOhRBuaEb0NtnuP1PO4JFymAIS76M9tob9IsBdgzAms5Vn+J/ZgJSBl/Y7qSDaaDuARhD/4FMf8dBJTLcRvyW/ZyZ0EaE2p83cg0tEKbJODaCsnG211eh+d5LlXmJFyVlIzFUCDc3i4PbEp0b8u3/6qSnLS6KVNKgZ2XbI43mk3TRJbt1NXR2JE3fwc2qeP/pnc/EYYXIs0lwCKVg+v+FixlcOds59m/NcNUYy2Fpi03Ih5ODaC+rVoGlxyYd1YkS6i6MIZt1gqGJCOr7QHFEjqE0yjSCI86Hhc/F8L+QFJ2pOdcm+gQl2mjZkpacF1r1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxy7ddXM5/iVz7dQM+/g/h7Sfs0xcpgmSTy3/rB54ok=;
 b=leEfaV0mZaNTx7a41efWHNJOQqw2XhMZpWK1HSbFi2t4LVLEswVYOhB2/U2GEH65d/Kx9UtrDUIiB41v/qaNfAzE+fb7t0q9fonIOwNmxcFAu+OhyJa86XeFkSDtvjoQ+hNTajuJEi28P1TUWJbU9SHZE6nnzM0FRrEJd/Zh4HwSkar/huKCKfes+lMJmnQSw6YHnni/0QFIvLD+jYX05xg1YzZmAsAAtgSuePSSGUSb6rILhnNcMBlDIJdlwKXncW7ry5G9BiCcoyMexT42Zf4FW3vvAV2xjdm0IqnYqRFzNLKlqwCmlktdZqy/DDUeVYk4fuGaWg8Oid3QjQVg4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxy7ddXM5/iVz7dQM+/g/h7Sfs0xcpgmSTy3/rB54ok=;
 b=RMXsCJzQo/TFJz7E7c/N3SrKaGIupdeWq93HyhrBwm/JG2qBsuFSPtFq559/tOagmfUEtL/hTTDyJN+pYXdq5ewNFKG9AwhOjGN4fmNPIr9J+3LqJaOrJ+KUMy1T9KMTY3Tuvpz4Qi3hns8bVmKV9y1ZVk79vYB992Ho+GOD4Nw=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SN6PR10MB3023.namprd10.prod.outlook.com (2603:10b6:805:d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Sun, 6 Feb
 2022 08:27:23 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%5]) with mapi id 15.20.4951.018; Sun, 6 Feb 2022
 08:27:23 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     david <david@fromorbit.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v5 3/7] dm: make dm aware of target's DAXDEV_RECOVERY
 capability
Thread-Topic: [PATCH v5 3/7] dm: make dm aware of target's DAXDEV_RECOVERY
 capability
Thread-Index: AQHYFI6KS6i0Tra94UqRHjnxZwdTsayC6KCAgANU/YA=
Date:   Sun, 6 Feb 2022 08:27:23 +0000
Message-ID: <1ae40b1b-9d07-a69c-aed8-e6a6b63b1cc6@oracle.com>
References: <20220128213150.1333552-1-jane.chu@oracle.com>
 <20220128213150.1333552-4-jane.chu@oracle.com>
 <CAPcyv4jw+meUy-DrLgqn_4kPCF2WAZrMJ8Nan4xCncr7-4Y0hw@mail.gmail.com>
In-Reply-To: <CAPcyv4jw+meUy-DrLgqn_4kPCF2WAZrMJ8Nan4xCncr7-4Y0hw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4bd7189-916d-4f78-3c87-08d9e94a8015
x-ms-traffictypediagnostic: SN6PR10MB3023:EE_
x-microsoft-antispam-prvs: <SN6PR10MB30234C76E263AAA5909016ABF32B9@SN6PR10MB3023.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eceUFfhwXR8OaQOrsJCNqrvDjKgZCTVkZcSCXVv/dZbD7sZ6c5fqEKkovIG3sHb2ZQWYdJVNXRhV0/nrG7JhtwsSROcpPpa0P4HCmZmz8iNeXHjkyIIpvmMRxNg2aY/FR15e/DHPFPn2gRg4Z4OCwou01BqOMqMk0QA3ye/vTPBv2XLk4u/Ao7fHCf5pWbv6vARKYZtccnygZD8ukUPC15X0aybIy8uQJGdDsf4JKkTgyH/T1Yared+L9x3wegzvrMbTiLavuMcIELWZhjmzB+MNPWKG+AU9aWNFWqGgznZL+AcFWPTYWKotjyRXsfQeiu7NWU7INlHWJVGJjkSTRt46o1aG2EAwV5hpdLb2Yj361cFB9tduVQMgk0/wvp47JjgzUZuGSrTaYtSKBdO7DF2cUzvYwWsUxK4LzTkSZQoLjp415VmdDMqrs91zv6/HpegUq/CDPyEA3EZy6R6jv5BsYSk/wr/rQ3qpXyrPaC0Z41JhiYXorxUCWz0/FEjz2+BGjGr1THFtbskzSgUmW+9OJpBrON0t3sH3GurLu4nI1AkTrquHqZ4gvH4SgUUya88QWYcLUtiErjennoJ/u7N5cTnueQaNpvty29AdkrJnq11h5+4+fAY0m+BGllHFHFRvykOxmBmiV1Rz1ZNTd4J+r23OXDyOoCS/uMtardzvvPXJiWCGedGUn3g2IHCrWVQEUcnZhDMhxJMJ7qSAZmE4VwULLaR6PmMlVtNuSPNClRNnzFYlGEYJWDOksNpHTjdh+ykzOwA/fwQ/FHVLXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(86362001)(26005)(2906002)(508600001)(2616005)(54906003)(186003)(316002)(6916009)(38100700002)(5660300002)(38070700005)(122000001)(4326008)(6506007)(8676002)(66476007)(31696002)(64756008)(66446008)(66556008)(76116006)(44832011)(66946007)(8936002)(6512007)(53546011)(7416002)(31686004)(6486002)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmJMZWtpK1dSbVIxYmVTZzJ1SG9VcFhKUThtSU1oazhJK1A1WmZZL1R4eHg2?=
 =?utf-8?B?UmU4YlVEQmpHcVljNUw4aWdHRWRNcmlENXZFYkJEbm5GbkFkVjZSY0VVRGQw?=
 =?utf-8?B?czFXYjJ2T2ZmZ203bm1kb2JGSHUrdml4TlMrVkEvOE9iUnNkYU53WDhGT3py?=
 =?utf-8?B?UlFjZ1BuYk9HZnFNa0IzSXptcnppZGw4V2lLWTRCWVo1MEZhMDU4dlMrcTJx?=
 =?utf-8?B?Tmltd2NxRHU2bmlBTGNLZ3RnQTgzbGdGbjlJNVVpMWJpZ2V2YWduTFhaMU0y?=
 =?utf-8?B?Z0NBdkNQNmVzaFVzSDhrT0JRcWdaNFlWNmt1MkNtT2RpUjF2V1BINEMrLzg4?=
 =?utf-8?B?UldhMFVPU3lZM1NDS1ZDZHhSb1UzUkc4bHh4b05pZndRb3hUYnd0WG1vdkJH?=
 =?utf-8?B?bGR0cC90U1BLMVZNdUttTE5xdjFidFgzaENoekJ2MVFoVGJHR3lKRWZDNmp2?=
 =?utf-8?B?UVVvRERIUFJpZHU4Ry9kSkNiY2xhUTFGS2VWZElGaFJRK09uWjk0bmN1NjNx?=
 =?utf-8?B?RFppc2R5VmJNM25KbVVGQnpvVm5JMGZHZk5LTDJYcU91SzBHNDV3VFh6QXg2?=
 =?utf-8?B?clRybmFxZ0VUdWJoUkxPOHFKTXVZZElHTUE1a2FtM1Ivd2U2NjZzcjgrOTM1?=
 =?utf-8?B?aVJmay84NG8yMjVJb1pJRlFXVUovL3lJcXFHLzF0aU4rcHZYR0dqMDBpNUNp?=
 =?utf-8?B?WHJsTG43Y2lBS0Z1bHdaUXBOdmw0OFRmNHZ2QXRhS29qQjBuZ2tVSEk0eXpv?=
 =?utf-8?B?WUptYXkvQVdNblJYeTVtSG5LclNwOVM2bFJkRzc1R1k3ck1VdGVvdVBXNkdD?=
 =?utf-8?B?NUJOa0RQck5za2c2MkdXVUhiUEVFVDBFeXg4RGVpSFdOaHNNQkFsazFpc3Ju?=
 =?utf-8?B?dHBuWE9Zd1NOcmluWGZ1TXEwSXlSZGRkaDV6eUNmNCtRcm5kTFQwZTFqY3pt?=
 =?utf-8?B?REJCQnJ6Nmd4M2pOcC9zZTd0S2ZkclUwK0VJbE9VN254a3RnY1FPd3U0REVY?=
 =?utf-8?B?OEo3dG8vNVZOSGNzYWZTdFJJZGVaQUhGMDlUMXZPa0hPZkphV3I2VXM0VmRV?=
 =?utf-8?B?MWp1VXNCWlYwQVN4SXBkUmZwWm5JN2FnclhVZC9naStISHBGVE9JaHNOdy8y?=
 =?utf-8?B?WC9RODUzSlNzNExZbHpnR09YcjdUOExad0dhMWVyQ0NOSUpvWkxUY1FvNXV0?=
 =?utf-8?B?eHVPS2Fkb3p0Y3lWVzNsUmZJdkdqaFhKYU56aHd0VDNKTnRkOVdrWFVPY1h6?=
 =?utf-8?B?cUVlU0NUd1REaWd1ejA1V0pIbWZjQmQzenVqRkw2M0hVbUptZXJXZDk3aGx3?=
 =?utf-8?B?aFB5VHFiNFdUUENDOXk4b1FVSVE5bWNVQTBsekRjRy9VendLcXVVcDdldUsz?=
 =?utf-8?B?Yjg3Ky9kdDlBQzdIMGNkSHF0aEVGSTFoRmpmV0hhTkpzNndNTUJPTEZkcXBj?=
 =?utf-8?B?Rk83MDYxTmdSMjlWU1hwa2lmbTQvWXpoOHYrd05WemhpNmZ3OWs5S01hQ3RJ?=
 =?utf-8?B?ODExeDdjN1ZBNnAveHBZbDhSMk96VjkrNG9OUEg3NlBBdGVPcGZvVFNFM3F1?=
 =?utf-8?B?NGV1emdjYTVSSXI2Qy9IMWE4MCs1UmJlTGtqRDdJU1BHNDhNWmY3blFzMVV1?=
 =?utf-8?B?UGFUWW9mTGp1bzdOcUttRUdQSmtIWHl6Vmdxa3dBVUlLL2MzdENRaWRmdllK?=
 =?utf-8?B?L2ZCWExmdWNkUTQ4Z0NnRURQa1M3YVM0Vjl4bGZGUnBobmVtZEFScktLaE5x?=
 =?utf-8?B?YnpHZmZkcnhEZlNydW14dGU2T1ZWQjN6aFRYaHNtUVpWSk5aTG1OL1Z2bTZr?=
 =?utf-8?B?b3U0M2g4dzAzQ1EvdmNnbVVPK3R1ZmpZSlI4dncxNmxTbHNYL25yZEQ4L2ty?=
 =?utf-8?B?NkJ0elMva0I2clN2K3cxSkNoeHdlWFFEQmFCaHBHaXZSbjUzL0VwdTBrMXQ2?=
 =?utf-8?B?QWtPbmRkQWpjc2FZWnYxdXkwRXgwWkYza2xDZnRnZENyVzlXMWZFc1huM0JC?=
 =?utf-8?B?Q3hjVzJFTW05MXMzcUp5bU9SeVlKekVHRnZNTVFWQkNzMG9DTmNJQjVjRVRt?=
 =?utf-8?B?eFZFMW42ZjRVODBKWkRLL2dBdTFpeVNjWVU1SGwrK3RKU0piY2k4MU5LR2ts?=
 =?utf-8?B?dGM1MnRKWTkzZEhOS3RLWlZFNUVyb3ZZNEh2bTJGVHV4NmZYeGx1ckJQcGJt?=
 =?utf-8?B?eWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AD509C9AFF26F4B84B0D9D1D02F5D57@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4bd7189-916d-4f78-3c87-08d9e94a8015
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2022 08:27:23.4426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tkm8drB1DxuBUPFqvC2KL8ZG+PmoSPC9hWz5J4WXtW61PSxh1v2wFB6AYmFmj3BCoaip6Ktd9o+7TCuJlWVePQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3023
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10249 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202060060
X-Proofpoint-ORIG-GUID: H1ymnY4MspNDnBKYkGJu9UBwAg65Wz_8
X-Proofpoint-GUID: H1ymnY4MspNDnBKYkGJu9UBwAg65Wz_8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMi8zLzIwMjIgOTozNCBQTSwgRGFuIFdpbGxpYW1zIHdyb3RlOg0KPiBPbiBGcmksIEphbiAy
OCwgMjAyMiBhdCAxOjMyIFBNIEphbmUgQ2h1IDxqYW5lLmNodUBvcmFjbGUuY29tPiB3cm90ZToN
Cj4+DQo+PiBJZiBvbmUgb2YgdGhlIE1EIHJhaWQgcGFydGljaXBhdGluZyB0YXJnZXQgZGF4IGRl
dmljZSBzdXBwb3J0cw0KPj4gREFYREVWX1JFQ09WRVJZLCB0aGVuIGl0J2xsIGJlIGRlY2xhcmVk
IG9uIHRoZSB3aG9sZSB0aGF0IHRoZQ0KPj4gTUQgZGV2aWNlIGlzIGNhcGFibGUgb2YgREFYREVW
X1JFQ09WRVJZLg0KPj4gQW5kIG9ubHkgd2hlbiB0aGUgcmVjb3ZlcnkgcHJvY2VzcyByZWFjaGVz
IHRvIHRoZSB0YXJnZXQgZHJpdmVyLA0KPj4gaXQgYmVjb21lcyBkZXRlcm1pbmlzdGljIHdoZXRo
ZXIgYSBjZXJ0YWluIGRheCBhZGRyZXNzIHJhbmdlDQo+PiBtYXliZSByZWNvdmVyZWQsIG9yIG5v
dC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKYW5lIENodSA8amFuZS5jaHVAb3JhY2xlLmNvbT4N
Cj4+IC0tLQ0KPj4gICBkcml2ZXJzL21kL2RtLXRhYmxlLmMgfCAzMyArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDMzIGluc2VydGlvbnMoKykN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZC9kbS10YWJsZS5jIGIvZHJpdmVycy9tZC9k
bS10YWJsZS5jDQo+PiBpbmRleCBlNDMwOTZjZmU5ZTIuLjhhZjhhODFiNjE3MiAxMDA2NDQNCj4+
IC0tLSBhL2RyaXZlcnMvbWQvZG0tdGFibGUuYw0KPj4gKysrIGIvZHJpdmVycy9tZC9kbS10YWJs
ZS5jDQo+PiBAQCAtODQ0LDYgKzg0NCwzNiBAQCBzdGF0aWMgYm9vbCBkbV90YWJsZV9zdXBwb3J0
c19kYXgoc3RydWN0IGRtX3RhYmxlICp0LA0KPj4gICAgICAgICAgcmV0dXJuIHRydWU7DQo+PiAg
IH0NCj4+DQo+PiArLyogQ2hlY2sgd2hldGhlciBkZXZpY2UgaXMgY2FwYWJsZSBvZiBkYXggcG9p
c29uIHJlY292ZXJ5ICovDQo+PiArc3RhdGljIGludCBkZXZpY2VfcG9pc29uX3JlY292ZXJ5X2Nh
cGFibGUoc3RydWN0IGRtX3RhcmdldCAqdGksDQo+PiArICAgICAgIHN0cnVjdCBkbV9kZXYgKmRl
diwgc2VjdG9yX3Qgc3RhcnQsIHNlY3Rvcl90IGxlbiwgdm9pZCAqZGF0YSkNCj4+ICt7DQo+PiAr
ICAgICAgIGlmICghZGV2LT5kYXhfZGV2KQ0KPj4gKyAgICAgICAgICAgICAgIHJldHVybiBmYWxz
ZTsNCj4+ICsgICAgICAgcmV0dXJuIGRheF9yZWNvdmVyeV9jYXBhYmxlKGRldi0+ZGF4X2Rldik7
DQo+IA0KPiBIbW0gaXQncyBub3QgY2xlYXIgdG8gbWUgdGhhdCBkYXhfcmVjb3ZlcnlfY2FwYWJs
ZSBpcyBuZWNlc3NhcnkuIElmIGENCj4gZGF4X2RldiBkb2VzIG5vdCBzdXBwb3J0IHJlY292ZXJ5
IGl0IGNhbiBzaW1wbHkgZmFpbCB0aGUNCj4gZGF4X2RpcmVjdF9hY2Nlc3MoKSBjYWxsIHdpdGgg
dGhlIERBWF9SRUNPVkVSWSBmbGFnIHNldC4NCj4gDQo+IFNvIGFsbCBETSBuZWVkcyB0byB3b3Jy
eSBhYm91dCBpcyBwYXNzaW5nIHRoZSBuZXcgQGZsYWdzIHBhcmFtZXRlcg0KPiB0aHJvdWdoIHRo
ZSBzdGFjay4NCg0KWWVhaCwgZ2l2ZW4geW91ciBpZGVhIGFib3V0IGFkZGluZyB0aGUgLnJlY292
ZXJ5X3dyaXRlIHRvIHBnbWFwX29wcywgaXQgDQp3b3VsZG4ndCBiZSBuZWVkZWQuDQoNCnRoYW5r
cywNCi1qYW5lDQo=
