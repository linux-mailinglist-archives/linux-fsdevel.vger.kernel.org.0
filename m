Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4774F6A43
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 21:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiDFTr7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 15:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbiDFTrY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:47:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C596014346F;
        Wed,  6 Apr 2022 10:32:48 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236FMiWY000752;
        Wed, 6 Apr 2022 17:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6+YOEqLXJ4ZRxuDBKaTFX+JC+XvGps7rJ6VNMz3NNDY=;
 b=JGPZXye5w/vvKYgGjJehn0aM1RS7FdhNgSzXMfLI6yww1LgS4lxgJMyaHKDQ261ev7UG
 Jg9ovPo4NxJ4HAdZ0DZZkUZNEDX4yuLwFO2Xo0BWSheYaZS+rrZPla58Yp6IfGSkz97L
 S5R+ILl6Fj0V26xr7AZAEVEMlPdKc9V7PE4CJO/kmCbwAYDbPcpU332zIcYxkRfI2mGs
 /tog337rWbsGs/e5zEm+DZnjigyNv0XDo4ePxsZC5VqF9glj7Jv/GcEEidedCjK32ziN
 onaHY5nr2R4eCU6ejoOhJXcNgsw/RzCBWuHwUS/it3y8poSBj1ECahZsyr3YpvUf5Mvz nw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6e3ssm3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 17:32:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 236HHKY1032416;
        Wed, 6 Apr 2022 17:32:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97uvusea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 17:32:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egADxBfLpOZDNoBtCQn+Gb4qONiP/sYwnLh9bgWji0LeOTGhDjFD5B/u2gAKL37tOLFyFihb0DpOGhJOQz48cg7lI1xDeMYKaPWmiEDcMVYsp/YoSx1qNEe2xPlWdw8SE3R/p0UawaqE34VIuTlfp6DiaU9q8LNfCCNeFtS9SR5tUodlm3NFqFT7tKVcfvrtV6/sbmR3+iB7U9NiSvLTsnvxFhBuR5BKILuJ4amMhTk4ujVNo1TCCVKgx/FEHHkKaCP/FeW64xBvC4JDAvIx3JCQcXcFkBEt45fiD2noXMfb3suAYwuDbEAiiGtg+z7MqgJOjzVd/pCZh47W1jGfbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+YOEqLXJ4ZRxuDBKaTFX+JC+XvGps7rJ6VNMz3NNDY=;
 b=LjfZE1ArpNz3utYcxqCcN5YtV8zDxoi/gSjvT8eHwT5YHVmie/jHEEeAQ1gcJq3kIcQ6e8wb3Q8pvSfBy0LVXf221yNJOw3kTZmr5sU1w1v31lMlE14IIxF0bzpDfPaUN7NXxPoEY27zUK5GWMewu9EZXXdqU44cPWEefQHSSeD1KtDDkxWrwSxZL3o8+faN2J3J3Eo+UpgGzaz6Nu9osP4QIx4Aa7W/HLKiIQnJSwGLpoclYgO0Dlfq5CeF0oiJzIbDbXmSHh+2N+pQlUzPYvTrQ/2ppirGu98n56YDK55kJd+Vr6BfiWD8bUQghGppdLq9enpxYZub+XuNYVGPwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+YOEqLXJ4ZRxuDBKaTFX+JC+XvGps7rJ6VNMz3NNDY=;
 b=GWNDM/iL9VY/pGhEOHd/V520K7TX+f+KN3AhONNSF3CpIDLBrKNRg6yHvqrNEETjkKsWUrhNWC05+ILc2Qx/uveZ2E2v5MonSfHeZP5G/gFgwzTmG3f9jL5wNn4FrnQgux+UevQ9/IixllQpdifjMo/hCC4Fc4ev/l+MOp+29hY=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BY5PR10MB4194.namprd10.prod.outlook.com (2603:10b6:a03:20f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.19; Wed, 6 Apr
 2022 17:32:31 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 17:32:31 +0000
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
Thread-Index: AQHYSSYdGKTdETDbkEmdZR/SZY7Ic6ziWZ4AgADMqgA=
Date:   Wed, 6 Apr 2022 17:32:31 +0000
Message-ID: <196d51a3-b3cc-02ae-0d7d-ee6fbb4d50e4@oracle.com>
References: <20220405194747.2386619-1-jane.chu@oracle.com>
 <20220405194747.2386619-5-jane.chu@oracle.com>
 <Yk0i/pODntZ7lbDo@infradead.org>
In-Reply-To: <Yk0i/pODntZ7lbDo@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 563668be-15c7-4b04-253d-08da17f36ddb
x-ms-traffictypediagnostic: BY5PR10MB4194:EE_
x-microsoft-antispam-prvs: <BY5PR10MB41940A3C0459728438D5771EF3E79@BY5PR10MB4194.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g8sdYEbxWhoKjojwrfHFTOgKG+ELw/bgOgrSimEoUuVeh89j5oH6kqx0zMxKjJkHrFbDVJPsJtJ0B+zIZSmsLMUCL2pm7GT2d4sEF184wc9j2p9o9meJOachrxD5OiIQIzkjf1zh8IRnP/cbXnzl5aWcOYiOCy+0h9u9QdCltSHuqiMl19ZFowcn2afFq1WcZyHJkw0043WkMuZZYN6l9Cxd8JlerSljUcLtmOdBCGVFvPvs5PPoKpiO70hEjO5itkQzZSWjscD4jxwGb6AKAoEm4Kn10IwEoZDdDK/3/6tgY8BU2iC29w34eAobhOcXu/2mfE51+eXEb8Fzi05fBW06nnYNBKZuHNCSfW3XkdFtCdRu/qRbdD/oPxjMbT6W6dhX6gQbZgJET1dfA/92oWsGb0ruDx1ZlGbKmoDR+Mph1df7t2JTbfl14dFrj6OpUbrrczGomu5yJThdH9Wi0iUY7v6c1eNj9ifNRJoU0PWPSh5kR8FJXPScorpnAAKXXPvRcHCVzdB6df34pu5QA2hghV/n8Gfn5Bajj/uzVzfqY6uLMHIMjwRKh9hxuj65/wZ4Pg5P98FME/4zCOCw7PkbzcGXn+8X/jG3bKgeq/KYZcKpZQBtwrfwMCdyFtM/k813PjLWNvgnzvfWxVvB8/EwN65tqsSPr97NtYmzYlYzdBD4f8esCToAhrQonQDOdFW726AxAsn2FDjgdJzETO+cr2NFAd3E5DvSo0WyZGsb+fOz6e4JIJJJMT6UBgo914gB/N86XwzJwC3ckc1ubThP5i24yU2pZTDX2jGabjVyzWisweakJXe2qpspqg12
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(31686004)(54906003)(7416002)(44832011)(38100700002)(8936002)(31696002)(38070700005)(86362001)(5660300002)(83380400001)(508600001)(76116006)(53546011)(66476007)(64756008)(8676002)(66556008)(186003)(122000001)(4326008)(26005)(2616005)(66446008)(6916009)(66946007)(36756003)(316002)(6512007)(6486002)(6506007)(71200400001)(142923001)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXhXV3F6d0lxK1lUNnQ2QjNlcENvS3I4Nnhqc3FoTTkrZ244VTl4YVJiUUFZ?=
 =?utf-8?B?VnI3UGU4dis1b2Fmdm5ZYlV4VjdGTDM4K1Y2T3U3dU5kRk9OenFjQUI1MGJB?=
 =?utf-8?B?SjRoaTZWMjBNYU5GOFRNbTZNZW9remY3c2xYT21MZThqR3ZsMzZ3Y0JIN1Js?=
 =?utf-8?B?elQwYWtDUDNPZThkN1MxVWRvZUM2dVJhSW5sQldpR0VuNm5hWmZyeWI5ZUVE?=
 =?utf-8?B?WjArNWF5ZU50WDFaVlNVMVQ3REZZT3VnRDlXenV6MWE0TVBaSXR4M1FVMnFq?=
 =?utf-8?B?TkVXNkhhOTFORzF6MlEybGFSdHBBaDJ6QkNDa3UyZHB0N2NnZE5QbVRFM3du?=
 =?utf-8?B?NFNpNUhOVUtMYmJYRkVrV1ZIU1o2QnlYU1VKeExDN0NjY0FhZXNYb21FT3dW?=
 =?utf-8?B?aUc2TDRWbTh4UkR0cmJDNGV0bElCbFl0U1lhQ2N2MllBMW8wLy93aWo1Nnp3?=
 =?utf-8?B?WG1nWVB3OHB5ZVdjSU9SVmtlNUkzNG11QWFJNncyaVc3WFNHRm9lcmNpK2lI?=
 =?utf-8?B?elRQeXJILzFaSHl5Z0VDcU1TRDNzcWttSjBMRlpqNjlUbGUreXZWbTBvUVMr?=
 =?utf-8?B?eTlCclJUd0dITXlQS1UxZDByM2dSTnFXakNSZjlNTDNEOXZ0aTkxMWF6d3VJ?=
 =?utf-8?B?Tmp1Q1V6U1VqOVRoTGwyR00xbnJBTjI2RVBCVjZsTEJYbmtabURHME8wdXZm?=
 =?utf-8?B?VENybGwyR0VEOTVqTWpEQmxCclRpNjZsMlg3NTlSYStWODNNeXpjQ0dDSXIw?=
 =?utf-8?B?VWdxOTFmRVpqZmpzeUx4S3FFOWZFb2IyaURKOHRhY00xT01TM1hDaktGc3lY?=
 =?utf-8?B?UVo5VjRSOEwrajAxN3VJQmE1QzBHbzdZMXVySmZvRkJyUDdUR3BWQ2VDRGdW?=
 =?utf-8?B?M2pvTDNKSFJ2U0pIbENSODJ6bFZGdmM5WGlyYk91SXI0UEFRRE9HWVBBbHN3?=
 =?utf-8?B?VzQ4TGJVaHdkb0FjKzVrOURnWkV4bDB1SjJzakFlR1gyS0QxT2wwWElhYlhw?=
 =?utf-8?B?eTAzUjFlS09BRFhsNTVzTUtycndUZU1JNGx6cTU4bDdpTnJMMzhvV01QbWEx?=
 =?utf-8?B?dUJzOE9Bai80cGx5ZkxMbWRnN0Q5MERWa0RlbDVPZGEwM1FDeVNqVGlqTEZZ?=
 =?utf-8?B?MEEwNk9tZ1p2ZXAxVHFUM3JDcVlXdkRjdnh3REtaVmFBMkJVckU1aHBleVp6?=
 =?utf-8?B?Vm5nT25wamMrMXVOM0EzUlc2WFVDZlc4c3RzLyttYlhkMnhNUlJPOU9EWWE4?=
 =?utf-8?B?TWJBQkFKSWNieDJpdWtBc0xieStxYVRMdTNMaFkveXJCYXhLQUpYdFNrcnk4?=
 =?utf-8?B?ZTR5Ui85bUdXNFdKeXFBK2RWVE13WGI4K0dGU3lWRjFDcVNhVCtYSThEeVZU?=
 =?utf-8?B?SkZTc3hESDd1ZlF3VmdyZTZWR0VzZHMzQVlKNUc2M2w3UmpCbmhrRWtFRGNV?=
 =?utf-8?B?YlY3QkxxZDdiZkd1UUMwRmV1MmlpVTZ3Tk5sc1pHS2tMTWlxTkI1c1ZFRGF2?=
 =?utf-8?B?a2RpamFTY1htM2pZWEcwY1pXRW9DT2hja3pNNVAvMVRqaHVhcGw2Ymt5bW9S?=
 =?utf-8?B?UGcvV0ZOR05OS3Qvb21HZW1sUldQSU5jZFFrVXJSQnRGVGJOK0ZuOXQxWENZ?=
 =?utf-8?B?UXR0ZG54Z0xBWjJZcktGVWxjWkJuVTg0dm96WXYrTncvdXJ0b0RscWl1b1Rv?=
 =?utf-8?B?NCtEUjVSOGtBbjR0TEc5ZEh2T2FyVjQyanVBbmNHUDJrN2NneFVqV0p4MHBz?=
 =?utf-8?B?ay9ZWlQ3K292c094UHBDZnlBcE05NmUxSjRuSzdEcFpyNEtRZ3Q0NTVnYmlS?=
 =?utf-8?B?K084bWNVZHJHVFJ0YitHR25zZEk2RmU4NTF4L0F5eHFiNnZ3YlNCdHN5UXNR?=
 =?utf-8?B?Y2p2RU5yWkdFYlhQUlhuNzdMRWlmSmxybFNzZytFOE1hYTR6STZsVUp1Ly9m?=
 =?utf-8?B?NUo5U2lYL3lXNVJmeXBLWjNzMThwRHYrSzIvcWFxZ2pJT3dzdjBSc2lUY2NX?=
 =?utf-8?B?SWFUWjlKT2FudUptV1QrVXpBVFBxSFNQZWhQQVI5Q0ZCM0xQTkx1ci9OSEh6?=
 =?utf-8?B?VjY0ajZJa1cySkxNT1ZuUitzUks1ZHVWQzA1c3RLSVBDa2hUWWZReTRtOTNJ?=
 =?utf-8?B?UEJKZUVPSTRMaEwxZE1nNmd4VXFxUDhHYWVndEVuVDVlSFJ3UEFPZDZpam1E?=
 =?utf-8?B?d2ZEem5IU2RaazU1VjZCWXZIcCtBUjhJdGZ4WXd2cEhKLzlUQmVYbDNpb09G?=
 =?utf-8?B?OHMrSVgrUzN3MkJlSEJGbDRramxncjdGNDZiSVJRcmNaMUZxSTN2S0VQT2c4?=
 =?utf-8?Q?2jE2GOPyk4Sw5Vhyql?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D25894A0F59B9B4EB755458807B215CD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563668be-15c7-4b04-253d-08da17f36ddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 17:32:31.2354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ym3ROX5nIyO2TpcLHD12r6u+QVi97T7su5B3Y59fynUDRWOeZ0cCjEY9LyOO65WButGWNh37jeRdUscZKsfidQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4194
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_09:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204060086
X-Proofpoint-ORIG-GUID: AttF8cHDVPgj3B68s1M8SyLakEdJNySz
X-Proofpoint-GUID: AttF8cHDVPgj3B68s1M8SyLakEdJNySz
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC81LzIwMjIgMTA6MTkgUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBUdWUs
IEFwciAwNSwgMjAyMiBhdCAwMTo0Nzo0NVBNIC0wNjAwLCBKYW5lIENodSB3cm90ZToNCj4+IElu
dHJvZHVjZSBEQVhfUkVDT1ZFUlkgZmxhZyB0byBkYXhfZGlyZWN0X2FjY2VzcygpLiBUaGUgZmxh
ZyBpcw0KPj4gbm90IHNldCBieSBkZWZhdWx0IGluIGRheF9kaXJlY3RfYWNjZXNzKCkgc3VjaCB0
aGF0IHRoZSBoZWxwZXINCj4+IGRvZXMgbm90IHRyYW5zbGF0ZSBhIHBtZW0gcmFuZ2UgdG8ga2Vy
bmVsIHZpcnR1YWwgYWRkcmVzcyBpZiB0aGUNCj4+IHJhbmdlIGNvbnRhaW5zIHVuY29ycmVjdGFi
bGUgZXJyb3JzLiAgV2hlbiB0aGUgZmxhZyBpcyBzZXQsDQo+PiB0aGUgaGVscGVyIGlnbm9yZXMg
dGhlIFVFcyBhbmQgcmV0dXJuIGtlcm5lbCB2aXJ0dWFsIGFkZGVyc3Mgc28NCj4+IHRoYXQgdGhl
IGNhbGxlciBtYXkgZ2V0IG9uIHdpdGggZGF0YSByZWNvdmVyeSB2aWEgd3JpdGUuDQo+Pg0KPj4g
QWxzbyBpbnRyb2R1Y2UgYSBuZXcgZGV2X3BhZ2VtYXBfb3BzIC5yZWNvdmVyeV93cml0ZSBmdW5j
dGlvbi4NCj4+IFRoZSBmdW5jdGlvbiBpcyBhcHBsaWNhYmxlIHRvIEZTREFYIGRldmljZSBvbmx5
LiBUaGUgZGV2aWNlDQo+PiBwYWdlIGJhY2tlbmQgZHJpdmVyIHByb3ZpZGVzIC5yZWNvdmVyeV93
cml0ZSBmdW5jdGlvbiBpZiB0aGUNCj4+IGRldmljZSBoYXMgdW5kZXJseWluZyBtZWNoYW5pc20g
dG8gY2xlYXIgdGhlIHVuY29ycmVjdGFibGUNCj4+IGVycm9ycyBvbiB0aGUgZmx5Lg0KPiANCj4g
SSBrbm93IERhbiBzdWdnZXN0ZWQgaXQsIGJ1dCBJIHN0aWxsIHRoaW5rIGRldl9wYWdlbWFwX29w
cyBpcyB0aGUgdmVyeQ0KPiB3cm9uZyBjaG9pY2UgaGVyZS4gIEl0IGlzIGFib3V0IFZNIGNhbGxi
YWNrcyB0byBaT05FX0RFVklDRSBvd25lcnMNCj4gaW5kZXBlbmRlbnQgb2Ygd2hhdCBwYWdlbWFw
IHR5cGUgdGhleSBhcmUuICAucmVjb3Zlcnlfd3JpdGUgb24gdGhlDQo+IG90aGVyIGhhbmQgaXMg
Y29tcGxldGVseSBzcGVjaWZpYyB0byB0aGUgREFYIHdyaXRlIHBhdGggYW5kIGhhcyBubw0KPiBN
TSBpbnRlcmFjdGlvbnMgYXQgYWxsLg0KDQpZZXMsIEkgYmVsaWV2ZSBEYW4gd2FzIG1vdGl2YXRl
ZCBieSBhdm9pZGluZyB0aGUgZG0gZGFuY2UgYXMgYSByZXN1bHQgb2YNCmFkZGluZyAucmVjb3Zl
cnlfd3JpdGUgdG8gZGF4X29wZXJhdGlvbnMuDQoNCkkgdW5kZXJzdGFuZCB5b3VyIHBvaW50IGFi
b3V0IC5yZWNvdmVyeV93cml0ZSBpcyBkZXZpY2Ugc3BlY2lmaWMgYW5kDQp0aHVzIG5vdCBzb21l
dGhpbmcgYXBwcm9wcmlhdGUgZm9yIGRldmljZSBhZ25vc3RpYyBvcHMuDQoNCkkgY2FuIHNlZSAy
IG9wdGlvbnMgc28gZmFyIC0NCg0KMSkgIGFkZCAucmVjb3Zlcnlfd3JpdGUgdG8gZGF4X29wZXJh
dGlvbnMgYW5kIGRvIHRoZSBkbSBkYW5jZSB0byBodW50IA0KZG93biB0byB0aGUgYmFzZSBkZXZp
Y2UgdGhhdCBhY3R1YWxseSBwcm92aWRlcyB0aGUgcmVjb3ZlcnkgYWN0aW9uDQoNCjIpICBhbiB1
Z2x5IGJ1dCBleHBlZGllbnQgYXBwcm9hY2ggYmFzZWQgb24gdGhlIG9ic2VydmF0aW9uIHRoYXQg
DQpkYXhfZGlyZWN0X2FjY2VzcygpIGhhcyBhbHJlYWR5IGdvbmUgdGhyb3VnaCB0aGUgZG0gZGFu
Y2UgYW5kIHRodXMgY291bGQgDQpzY29vcCB1cCB0aGUgLnJlY292ZXJ5X3dyaXRlIGZ1bmN0aW9u
IHBvaW50ZXIgaWYgREFYX1JFQ09WRVJZIGZsYWcgaXMgDQpzZXQuICBMaWtlIGJ1bmRsZSBhY3Rp
b24tZmxhZyB3aXRoIGFjdGlvbiwgYW5kIGlmIHNob3VsZCB0aGVyZSBuZWVkIG1vcmUNCmRldmlj
ZSBzcGVjaWZpYyBhY3Rpb25zLCBqdXN0IGFkZCBhbm90aGVyIGFjdGlvbiB3aXRoIGFzc29jaWF0
ZWQgZmxhZy4NCg0KSSdtIHRoaW5raW5nIGFib3V0IHNvbWV0aGluZyBsaWtlIHRoaXMNCg0KICAg
IGxvbmcgZGF4X2RpcmVjdF9hY2Nlc3Moc3RydWN0IGRheF9kZXZpY2UgKmRheF9kZXYsIHBnb2Zm
X3QgcGdvZmYsDQogICAgICAgICAgICAgICAgICAgICAgICAgICBsb25nIG5yX3BhZ2VzLCBzdHJ1
Y3QgZGF4ZGV2X3NwZWNpZmljICphY3Rpb24sDQogICAgICAgICAgICAgICAgICAgICAgICAgICBp
bnQgZmxhZ3MsIHZvaWQgKiprYWRkciwgcGZuX3QgKnBmbikNCg0KICAgIHdoZXJlDQogICAgc3Ry
dWN0IGRheGRldl9zcGVjaWZpYyB7DQoJaW50IGZsYWdzOwkvKiBEQVhfUkVDT1ZFUlksIGV0YyAq
Lw0KCXNpemVfdCAoKnJlY292ZXJ5X3dyaXRlKSAocGZuX3QgcGZuLCBwZ29mZl90IHBnb2ZmLCB2
b2lkICphZGRyLA0KCQkJCSBzaXplX3QgYnl0ZXMsIHZvaWQgKml0ZXIpOw0KICAgIH0NCg0KICAg
IF9fcG1lbV9kaXJlY3RfYWNjZXNzKCkgcHJvdmlkZXMgdGhlIC5yZWNvdmVyeV93cml0ZSBmdW5j
dGlvbiBwb2ludGVyOw0KICAgIGRheF9pb21hcF9pdGVyKCkgZW5kcyB1cCBkaXJlY3RseSBpbnZv
a2UgdGhlIGZ1bmN0aW9uIGluIHBtZW0uYw0KICAgICAgd2hpY2ggZmluZHMgcGdtYXAgZnJvbSBw
Zm5fdCwgYW5kIChzdHJ1Y3QgcG1lbSAqKSBmcm9tDQogICAgICBwZ21hcC0+b3duZXI7DQoNCklu
IHRoaXMgd2F5LCB3ZSBnZXQgcmlkIG9mIGRheF9yZWNvdmVyeV93cml0ZSgpIGludGVyZmFjZSBh
cyB3ZWxsIGFzIHRoZQ0KZG0gZGFuY2UuDQoNCldoYXQgZG8geW91IHRoaW5rPw0KDQpEYW4sIGNv
dWxkIHlvdSBhbHNvIGNoaW1lIGluID8NCg0KPiANCj4+ICAgLyogc2VlICJzdHJvbmciIGRlY2xh
cmF0aW9uIGluIHRvb2xzL3Rlc3RpbmcvbnZkaW1tL3BtZW0tZGF4LmMgKi8NCj4+ICAgX193ZWFr
IGxvbmcgX19wbWVtX2RpcmVjdF9hY2Nlc3Moc3RydWN0IHBtZW1fZGV2aWNlICpwbWVtLCBwZ29m
Zl90IHBnb2ZmLA0KPj4gLQkJbG9uZyBucl9wYWdlcywgdm9pZCAqKmthZGRyLCBwZm5fdCAqcGZu
KQ0KPj4gKwkJbG9uZyBucl9wYWdlcywgaW50IGZsYWdzLCB2b2lkICoqa2FkZHIsIHBmbl90ICpw
Zm4pDQo+PiAgIHsNCj4+ICAgCXJlc291cmNlX3NpemVfdCBvZmZzZXQgPSBQRk5fUEhZUyhwZ29m
ZikgKyBwbWVtLT5kYXRhX29mZnNldDsNCj4+ICsJc2VjdG9yX3Qgc2VjdG9yID0gUEZOX1BIWVMo
cGdvZmYpID4+IFNFQ1RPUl9TSElGVDsNCj4+ICsJdW5zaWduZWQgaW50IG51bSA9IFBGTl9QSFlT
KG5yX3BhZ2VzKSA+PiBTRUNUT1JfU0hJRlQ7DQo+PiArCXN0cnVjdCBiYWRibG9ja3MgKmJiID0g
JnBtZW0tPmJiOw0KPj4gKwlzZWN0b3JfdCBmaXJzdF9iYWQ7DQo+PiArCWludCBudW1fYmFkOw0K
Pj4gKwlib29sIGJhZF9pbl9yYW5nZTsNCj4+ICsJbG9uZyBhY3R1YWxfbnI7DQo+PiArDQo+PiAr
CWlmICghYmItPmNvdW50KQ0KPj4gKwkJYmFkX2luX3JhbmdlID0gZmFsc2U7DQo+PiArCWVsc2UN
Cj4+ICsJCWJhZF9pbl9yYW5nZSA9ICEhYmFkYmxvY2tzX2NoZWNrKGJiLCBzZWN0b3IsIG51bSwg
JmZpcnN0X2JhZCwgJm51bV9iYWQpOw0KPj4gICANCj4+IC0JaWYgKHVubGlrZWx5KGlzX2JhZF9w
bWVtKCZwbWVtLT5iYiwgUEZOX1BIWVMocGdvZmYpIC8gNTEyLA0KPj4gLQkJCQkJUEZOX1BIWVMo
bnJfcGFnZXMpKSkpDQo+PiArCWlmIChiYWRfaW5fcmFuZ2UgJiYgIShmbGFncyAmIERBWF9SRUNP
VkVSWSkpDQo+PiAgIAkJcmV0dXJuIC1FSU87DQo+IA0KPiBUaGUgdXNlIG9mIGJhZF9pbl9yYW5n
ZSBoZXJlIHNlZW1zIGEgbGl0bGUgY29udm9sdXRlZC4gIFNlZSB0aGUgYXR0YWNoZWQNCj4gcGF0
Y2ggb24gaG93IEkgd291bGQgc3RydWN0dXJlIHRoZSBmdW5jdGlvbiB0byBhdm9pZCB0aGUgdmFy
aWFibGUgYW5kDQo+IGhhdmUgdGhlIHJlb2N2ZXJ5IGNvZGUgaW4gYSBzZWxmLWNvbnRhaW5lZCBj
aHVuay4NCg0KTXVjaCBiZXR0ZXIsIHdpbGwgdXNlIHlvdXIgdmVyc2lvbiwgdGhhbmtzIQ0KDQo+
IA0KPj4gLQkJbWFwX2xlbiA9IGRheF9kaXJlY3RfYWNjZXNzKGRheF9kZXYsIHBnb2ZmLCBQSFlT
X1BGTihzaXplKSwNCj4+IC0JCQkJJmthZGRyLCBOVUxMKTsNCj4+ICsJCW5ycGcgPSBQSFlTX1BG
TihzaXplKTsNCj4+ICsJCW1hcF9sZW4gPSBkYXhfZGlyZWN0X2FjY2VzcyhkYXhfZGV2LCBwZ29m
ZiwgbnJwZywgMCwgJmthZGRyLCBOVUxMKTsNCj4gDQo+IE92ZXJseSBsb25nIGxpbmUgaGVyZS4N
Cg0KT2theSwgd2lsbCBydW4gdGhlIGNoZWNrcGF0Y2gucGwgdGVzdCBhZ2Fpbi4NCg0KdGhhbmtz
IQ0KLWphbmUNCg==
