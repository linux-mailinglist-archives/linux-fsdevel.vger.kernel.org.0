Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3C769E54B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 17:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjBUQ6h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 11:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbjBUQ6g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:58:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA19B4EF8
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Feb 2023 08:58:09 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LGhpCA016517;
        Tue, 21 Feb 2023 16:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Mwr44+o4YKSofV+wikYsViZN4Xu2e/Pbo/1rocfDiV4=;
 b=Im8J2kOhrrU37HcSQSISjt/2Zf5lx3BSBAV0qZe96Wt6JSN7eljUSYcUHP3ADZuiykn9
 2Zgcu1N56Dwm1+IXsrGQfDVUgg33RTsvxxQBEIAWH1d49G/1Mm7Bh+tBO0qyfAfAR4hw
 xjsSK/rKduBhjK8lpPN9WJGfqvZyT/b5CBRZhIE4UGCcUxQFNfH6bKhe1XcdjRIf1VWl
 zGEUXMFQmxLJDP61/8Z8+NDMDDIW3sytnPScblqxp8spgRz0zcDQB4H4K78C4uycHqNG
 SWHy9B+Jsgnd/MK8xQc7/ryvEvpVDTD0XvmFNSFeNBSHaO7qSepFQMG4a1VOAhGxK3KW Tw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntq7udnve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 16:58:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31LFU3YP031500;
        Tue, 21 Feb 2023 16:58:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn45bw25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 16:58:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvf5+3RftJvI2xEtN9RFopGz0NDiQm8AoBRSzyvDa0mrS+H4ZCSJcK2umatj2oa6KKWqE92oVzbP51VP2z6v/e19VK/3SC7K0JSDNUdxaVJrdLBsjVYnB9fZLAK1q9l59lxAEuVyylXrpaXtXMpPR4XHMzXd+aPtq5inH1kOLAWjgq7466zNzFZSMevLsgTXcP7DfsiorWTeel1JUvv2J2VEpyucWjAYVxtKuuR/3NVqU4oYU8xkVEgt8tlTOnBAyblza7xdaAqr7xP3zCiixGzdMPOoegxT1CZ9WrizuhlMko16o8s/alJrY0we8jKOK7rhqXFVRBmunyuSq+HVBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mwr44+o4YKSofV+wikYsViZN4Xu2e/Pbo/1rocfDiV4=;
 b=YnN9/EteIy5KraTn/mLWbckGkSUgNQhck4l0mXpR4GODWSZZ4E57fzy4Eznxa3uXNFFwtCj8wQJK0dO0helrONeLKOePTXR4k1wZO77YibUuLUcJWzvp2c073g8iazjCqwxd7J4I4wb/DmTmwYS2U2kH344WfON/1XNJI+hjPtGkKBnPHOAoJ4zxFTFQ8hcCb/c4pyLASgATlyP+9aqSwVNjwsWgyQL+UidjlKT1smpwHZpHS+ieGJX1l3PVrjKN+1ggi7oEvSRrBf/PdSGdW5Oj2EYt0qLtWPDPw3h6y2yRnxYkFhcet4Bh3Khn2/GbNxWfaeeYsk+qewm4GICMhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mwr44+o4YKSofV+wikYsViZN4Xu2e/Pbo/1rocfDiV4=;
 b=QWPc/RBEzqEAJsUYqkc/2VcNfOBcj65cgxWGKkfg6ZyCq7EPRWIB6kYOGnoYspsbim50s10XshI76AxPXGswyAv1lTBArUnTEaJKjZ1+swRTTQB2UEgghgvjAi36DF6Avm10h8MCJoDIh+4ics0x9asLRE9sD4d5MFxadbIvQ1A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN6PR10MB7423.namprd10.prod.outlook.com (2603:10b6:208:46c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17; Tue, 21 Feb
 2023 16:58:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5c2f:5e81:b6c4:a127%8]) with mapi id 15.20.6134.016; Tue, 21 Feb 2023
 16:58:03 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     David Howells <dhowells@redhat.com>
CC:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Linux Security Summit cross-over?
Thread-Topic: [LSF/MM/BPF TOPIC] Linux Security Summit cross-over?
Thread-Index: AQHZRhVake7pth+yaEiYhtqGfgrJbK7ZnyYA
Date:   Tue, 21 Feb 2023 16:58:03 +0000
Message-ID: <FAD49DB3-977E-4DFE-BC51-B3B3272FBF4A@oracle.com>
References: <2896937.1676998541@warthog.procyon.org.uk>
In-Reply-To: <2896937.1676998541@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN6PR10MB7423:EE_
x-ms-office365-filtering-correlation-id: 8a797fd1-991b-47e2-dc53-08db142ccbd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rHPG/eQzyBB9Dr8D2QHaDTXsx76o12G2d6csexITbxWtjfv9+flDUsEijhp4fOTiKvSmIEwHEHZiAbg5wsj0Szpw69kEe7TCYEdPRYi3cI6jT1kro5Ifzr9JmA67TBUfHxVY/DjS8SAobr9Zg/8DYpMBWSJoffrsSPjs9n9YRvp+cNQEjO5wO2ZlWKnT9bIRCtB00//s1QAnbWYKh8WI0wvk/XypDtjnDz8ritT5uJZ/9EZH/9ISCj/h2R7gr38DBePRZcf0oX9dVfolWWRimSYicaiop+cWeev8mrlG1w47wFbaLsZmkQ3SSr+O390E394MHn3ddGIusXsKLekA59frsroryQRi/J31bFfXBJHN3grnQrEUE9djqqz6X/f68pLl9400HyTGjpIweFu3uMGDhc/mearRhvGfqPNIeJktzui/6Cm7QlIS+bl5eP8rfkbV5VLrGf9vvuP7MqxBiquYH4axOqLEMWvRW8YuKgEyiU3XqfHGRa7YqhSA1dIdiwBdZxAjy29z4NW+nXzGxVZNpqBfUcFAzcmsiYkIySMsCaaaS+5nyYKbnIv3KtS6Io7jsT1XyBqU4XpYc/RvrrzEC+I1DNYjazjuCHGTyY29RCI6BW8N0j0KMwfZYu0Opm7rIHf5iR1TQ9MLPfJ1bPdbpRW8yqe7RiwzTKY2yfeffdJg+6XqLtt7tARHsbHnpSniiYl5fuLh12xr8YXFLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199018)(41300700001)(38070700005)(316002)(86362001)(54906003)(83380400001)(33656002)(36756003)(71200400001)(478600001)(966005)(66446008)(66946007)(6486002)(64756008)(66556008)(66476007)(8676002)(4326008)(91956017)(6916009)(76116006)(2616005)(122000001)(5660300002)(8936002)(38100700002)(6512007)(186003)(26005)(2906002)(15650500001)(4744005)(53546011)(66899018)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTczdXdKbEpuNTVzQWdSU2NLU1VDUzA5TERSUWVTS3NTdVk3MkM3L2dGV1BR?=
 =?utf-8?B?SlZMNkhHWWZadjUxL1dYLzk0bWdjcElPMGVjNUNaeTBQVW9YRnJmMThkVW50?=
 =?utf-8?B?U21Jb0ZoaWpNeWh0MnhaaWFDVndLOUV5YXhDaTQ2bzVYazErMzlNby9zNG54?=
 =?utf-8?B?cTB2aWR6YjV5dWVjTFFWcU1xSG1aSEl6SzdtRXoxM2Rhem8xOVdmM3Q4QjR6?=
 =?utf-8?B?Smd1WFpnR1VjbGJxWHMxTnQvT2F3Ynp5WTZFVk81ZGtaV2xJNUFJd25rWWhJ?=
 =?utf-8?B?emsweXAwc2ZibGFtQjhwY0Z2YWJkSjZtRHR0Vk85YysrRS9BVGt1bU5DQmcz?=
 =?utf-8?B?Rk1vK3B5YUZtc2R5NnNXWm9INFpVMWc1Q2Z2OFpXaGpaV3NJZVpDR0R0WEFO?=
 =?utf-8?B?ZHdZUFV6N3hOZTYrZ2FIQWp4Tm5JNnI0ZDlTU1lCWE5wYUhBbGsxU1FSL043?=
 =?utf-8?B?OXhJT3hVQ28rRkhHTUdDNEJLS1RFOXVlZk93NmtBMk9qY3YzdGVCejZmbTNy?=
 =?utf-8?B?MjA5SjBwREs0a3JZeHh1UjUyc3pYcGJwVHBnZ0xyemhzSm9ITmtZb2R6c0lX?=
 =?utf-8?B?U2t4cG9KZFNFV1BZeXhNSVYxWVV4SHNhcjNXeGJQSXNNYUluNURqeTcyQTNz?=
 =?utf-8?B?UFB4alphSjRZKzA0M1Y2VDhmTGlGYVZuNysrWEFGQWxkcEdGWDM3clhEOE00?=
 =?utf-8?B?ZGRCWm9DVDFpZ2t6YWE2ZXNQbTQ0WGVkZnc1S2NPQWQ5SmNVUVlDTGxVTVZS?=
 =?utf-8?B?WWd0RkFxdk54V1poTFFpMGdkZnYwdkRvZytEdk1ZZ2o0WVpzQ2FQSVhRanFJ?=
 =?utf-8?B?RW4zdStoamg5cW9ZQkZwcEc5VytRTjlqeUIxenE3cE10SHdPWkE0NHRGcHFR?=
 =?utf-8?B?UVB4WENvTXRjbDNZLzJuQm9nakdjSS92emU3c2xpdFhNd2JESVFzRFV6T0hM?=
 =?utf-8?B?S1hiYTlhS21vUFRiVW51MllJQzhCby93eVZ2T3hmUWFjNCtFenpZbkg0T0xo?=
 =?utf-8?B?SldtNzNIR3RnZCtDZVJjNnVFWk5zRDNTVU5YUWRaY0FyY1dOaHpkNzMvVVJr?=
 =?utf-8?B?ODluRjlJRmVCak91eW5YYk9yc2J4a2hXWFhRcTdtVXpGaGNFbzlKMlB4eFp2?=
 =?utf-8?B?enhsVVJ6a0RGZEFXSjdtQ0I0Tld5czcrOVpNZmJTMlZqVzBjTDRwNUo4bml0?=
 =?utf-8?B?WjRLTHpCWG5DdVBnbFhCdDdsVWo1NUV3ZXlNZDdFaGIrYlljYkV2WGFva3Np?=
 =?utf-8?B?STY4WCt2aVphMlVFZHMzK3NqNU1KbXEyeDRqQlQ4ait4cUhFbHkrMUxvRnVk?=
 =?utf-8?B?bVhLWW1wUStNVFZnRmNzZHBOaUhnUk1NdDVhemprNUo1aExkRkVTcEZHbDRH?=
 =?utf-8?B?dUxoT3pOMGMvYkN4K09mRVZ1dHlzeVYrTkZHSFo5L2NDQW54YjhoT2ZNeER4?=
 =?utf-8?B?dTc2cUIzZ3A2cG5sRzl6Y2pudmZOYlg1d0xmdG82dHZpTVhLbHZ5d3NHaXVB?=
 =?utf-8?B?TmJsbm9YQWZvL3p5aWNvQUkzdEgrL24zNTIvSGE2T3pGOXNmTGNkYkdTd3gz?=
 =?utf-8?B?Zkd3VWRzZ2p4cHpaNUJhTnBJNFZISTZwUnlkc0N2RW80anFHaEJpMTdjWGpk?=
 =?utf-8?B?NFhiTmIvT3Z5eGxwelNGMkZpeTNtWUpHZk5LVCtFeHJURTBBaCtxdENJV1kr?=
 =?utf-8?B?VUlkaTdkQU1kdzBWUW1DWVFRR296NTZuUTdjR0tVTEJzS0IrZGE0M1hLZ1M1?=
 =?utf-8?B?NHo0bDhTblRiUmh6MHpTdDMyZDY2cERRL3BLamd6VGlibm04L1R5a1lMNVVZ?=
 =?utf-8?B?VHlwSWF4ZEN4dllpb2szdTNKaFZGLzBFOWcwWFdRZ1JIaWNjbUZSYjFHdWc4?=
 =?utf-8?B?NTFVZkNjVWNQdUNYQ0toT3AvSUx5c3AxOFUrM3ZUWDU0aDVObm1XNnhMd0cz?=
 =?utf-8?B?YnVYRnF4OVBDa0dPSVNQQ2ZTM0dWVW41aFhvdGpMRGtCNk5SbGIzOHVhT01C?=
 =?utf-8?B?T0I1dk1FbUs3VzB2SXhQQU1tcngwcmQ5cFEyUnhuenpKbVZQQXZxR1RMUllJ?=
 =?utf-8?B?L3Fnc3dvMnF6WHEyM2p0SjFSVGtMc3pOMmtmOVljWTE2OWwzOXltSlAra2Rs?=
 =?utf-8?B?anRZaW12RXBDL2VpSWczZVZZdlpkL3VZQ0ZUaXphUnlWay80blBoNEl2N2pv?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A041E630C190F43B4A5D86CA6CD4394@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fWKgStPcNoCwl+iP/is3huRzGKnXcOpnvj2BCWxauQ3Uk38TauupsQ75CZfLQyuS4DY3266FdLhkWLTLOyOmYIkrwZXGIXLD0ri480g+71awcfYD4XOrXJ5Dr9pycfp6UkXlkzQSGXOB1fq7C/lcb32IGws3BTffQd+H+L8qa18Gs14Wqrry/qVvOPPRW7tjzN9cEggreSHY1Ie2G/gFK4eneOheYd5ZNciBWoENsgVCd2BuO4vwYOPoCnuq6gY+fJIgrAggoupxUrdm3rISzKBD0tjSXD7pTUfaYhqFdqGeq0dxMPVzuUUdhaAGQIvLUvHGR5BtEsLOlGHWHESbEQKpkm9pf7MN3aYUmFEDjhQqlqvakUt5DEqCjlVdF0ZrTkcx4N7+392KMNi/sNwo0Pn40vi/sx36GCiYssVJoMZ32m339wN0d7biXMusY1x9mOqmedbTdHVIqdtUbpoxzdwa9uB0qWw3REdqzWU+pBmICKX4BVSnO/eOluOK0XMSC85cjV77mo5UP8hmepSFvroywHGI1I036YRu8n9wfoGXkj2E6xs6naXG6hOZ837R4Zq1Fa4VTadzDPGb1jIGTz0JZGPn4NoPJpaHItWPVeMDN5y18ZSYtNSy/xKE4p0Gno/NTcsnF3jmsWsoZFRiDdpDXSAU1e1RLsg6a6QbzpE3OEIxgsltd9azDFRZn4QaEeVzXsJMxAs6emEvPg99lLdWT+DEfd3oIB/WzKiEaXcFH1J4/THpoLhaPnumhJn9+ikUSfctP/i+GoweHCmD2hvfs4mekyDDm8oXc59fWxYMW0y/kynyfcrXIqR60VFzco/ih4rFNgImM+n+Mg88pwve4m2g8rFiFWsHq7GltWI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a797fd1-991b-47e2-dc53-08db142ccbd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 16:58:03.3692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dEa5BGMi9UhRh5GTnolUHjPfFqXVIdf4IsIyhyCOzZ1M9zYPdMxc+BOMK8wctUGYfz/BWlcGd1OMUAAm3SbjiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7423
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_09,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302210142
X-Proofpoint-GUID: hMZmKetTz_21XmAVxMt8hrFfSFxU-cR0
X-Proofpoint-ORIG-GUID: hMZmKetTz_21XmAVxMt8hrFfSFxU-cR0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gT24gRmViIDIxLCAyMDIzLCBhdCAxMTo1NSBBTSwgRGF2aWQgSG93ZWxscyA8ZGhvd2Vs
bHNAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gU2luY2UgdGhlIGZpcnN0IGRheSBvZiB0
aGUgTFNTIGlzIHRoZSBzYW1lIGFzIHRoZSBmaW5hbCBkYXkgb2YgTFNGIGFuZCBpbiB0aGUNCj4g
c2FtZSB2ZW51ZSwgYXJlIHRoZXJlIGFueSBmaWxlc3lzdGVtICsgc2VjdXJpdHkgc3ViamVjdHMg
dGhhdCB3b3VsZCBtZXJpdCBhDQo+IGNvbW1vbiBzZXNzaW9uPw0KPiANCj4gTFNGL01NLCBNYXkg
OOKAkzEwLCAgVmFuY291dmVyLCBCQyAoQ2FuYWRhKQ0KPiBodHRwczovL2V2ZW50cy5saW51eGZv
dW5kYXRpb24ub3JnL2xzZm1tDQo+IA0KPiBMU1MtTkEsIE1heSAxMC0xMiwgVmFuY291dmVyLCBC
QyAoQ2FuYWRhKQ0KPiBodHRwczovL2V2ZW50cy5saW51eGZvdW5kYXRpb24ub3JnL2xpbnV4LXNl
Y3VyaXR5LXN1bW1pdC1ub3J0aC1hbWVyaWNhDQoNClR3byBJIGtub3cgYWJvdXQ6DQoNCk5ldHdv
cmsgZmlsZXN5c3RlbXMgaGF2ZSBvbmdvaW5nIGludGVyZXN0IGluIHRoZSBrZXJuZWwncyBLZXJi
ZXJvcw0KaW5mcmFzdHJ1Y3R1cmUuDQoNCk5WTWUgYW5kIE5GUyBmb2xrcyBhcmUgd29ya2luZyBv
biBhIFRMUyBoYW5kc2hha2UgdXBjYWxsIG1lY2hhbmlzbS4NCg0KV291bGQgYmUgaW50ZXJlc3Rp
bmcgdG8ga25vdyBpZiBMU0YgYXR0ZW5kZWVzIGNhbiBnZXQgYSBkaXNjb3VudCBmb3INCmF0dGVu
ZGluZyBMU1MsIGlmIHRoZXJlIGlzIGEgcmVnaXN0cmF0aW9uIGZlZSBmb3IgdGhhdCBldmVudC4N
Cg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQoNCg==
