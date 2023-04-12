Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCCD6DFD77
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 20:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjDLS10 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 14:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDLS1Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:27:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F614C2F;
        Wed, 12 Apr 2023 11:27:11 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CHDl98027258;
        Wed, 12 Apr 2023 18:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=corp-2023-03-30;
 bh=9udu/K9M5NZIKAdl+yCLrCtiMUN2QvKd/S9QaXiCmm8=;
 b=jZYTZuMs2K0qQxWZbL7IUwLtSJlqqEs6Xg0lg54W45f2EeBcHKKHElmABnKZLM6SKmUX
 rqENgi33+ktWMjCQE09wnBimTTtcic1MYAKkpqnmt2GmIg3usc7lHUtrtyAKFPaBl2Nv
 20twOTB72HoMzJxTMBeffO2DeTULqMryUsTIFO423HoI07Vl+9k2pG/XXMGDSC7xUkgx
 z0ufSrzC3sXE66vtKzrL9EmSmW/EJQmp7/0RFPp/Gg+OC4N+XZ3tpCgUfb3sSiVq9FyH
 B5m81LjTTzjcAIjNxdWU/Dshjgrnmt/hLzed/QC1wcT8KVOEH11SNDJXnUG7RuCXMrOT HQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0bwh470-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 18:27:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33CH1p5e012601;
        Wed, 12 Apr 2023 18:27:09 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puwe9g6r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 18:27:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsFZ1hKraBkXVE3HVJNk+ZyeU9252lC5AdS/SX2mm3x1JJyv/u5c1X0FQwxiF8U8CZPVNiiv+Wv/QVkWIMqQOT8m+jEcltQ0NqwdTdpaXL1kKafJKE0iqf2xRKSkcz+KuAVo+DECrcVQUGbWZvFaR/6s5sHS1bOvTP9lg7xjGLTvmYRO8kXmJsrStPG8v4W45a6dQaL7lM/sTLAaFB2c8u0TX1QS+WB8EyZhdDew9x+Vxwar3x5/TdDuRkraz7j4T1O1eCiaYeSGktfGkQlvBSC+8LljjBNBtiP5B/xcT0RjHdZLZL6LxfsFSXrQZQpZEWFZYFTI93HBTNQVBv7Yfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9udu/K9M5NZIKAdl+yCLrCtiMUN2QvKd/S9QaXiCmm8=;
 b=UjVAUT6BD9jLoq+Qrh4kdZ+jCVJ3A0IcOsjMI68nSRlpdl2+VlPYEbAZhiWldDoSy5bsNusW/nO93YOSWUsoZz+b+1xmmqWzcqIGF19BPUWjxUWNBx10t/CUUAmLUe8S8yVYwjEJ0PqJ1vaf6hgM4059L6ixeHUuMis7PxMQ9yS2swlcEIDdywBrNih9rPyqxfMSpPTcDI5RyrpRaxBB28jvsLPaXkWX+8QgObjqRMDQcvPp4Qy3d2pY+1H2vLt54TwWQ3j+YFhLG9ne2k9oGEkaZ8o81s0NgNEJNHI1Y4t6GbFxwiez2M2OeJ7ZJym0PwywMn/FvugQnSskJJDW9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9udu/K9M5NZIKAdl+yCLrCtiMUN2QvKd/S9QaXiCmm8=;
 b=yzuoag2mVbKsHe6W1sx2Ne89El4zzyPGDAtMJ3vr4tUvYATqAy2RdlYLQHXo5W+exUhGqY516kmYUPg9SPQh0Xh1yKjdqR5GtSZINC1JefISaOeuLSWnihyBd9//AJgCmfo3Ml56kFQXWYfaJ+WN/zUGrp638HxvxUeqtxvd8nU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.36; Wed, 12 Apr 2023 18:27:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%7]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 18:27:07 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: [LSF/MM/BPF TOPIC] BoF for nfsd
Thread-Topic: [LSF/MM/BPF TOPIC] BoF for nfsd
Thread-Index: AQHZbWxjbwN4AXhTVEi8u3WYTLTb1Q==
Date:   Wed, 12 Apr 2023 18:27:07 +0000
Message-ID: <FF0202C3-7500-4BB3-914B-DBAA3E0EA3D7@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB6078:EE_
x-ms-office365-filtering-correlation-id: 60e61128-00f9-4aa7-b04f-08db3b8385cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S8f/FX9I2sF4ujl0Qyerh4SluHXk1pEofKj1778cxttbt3SIivUPHE1Mcq5XsUyxYdUPMcuPsEZ/nbADECUB9hApuTqeIa3x6CmNqdswKu5Z3W8eL8XwU857E884k1sJ0YXMXEIccixKDEELo4TnLyMOByHeClJlzoi/zwN1pfVempTiz1K2Rf4ZR4By+9NcNO87oAUrzX1OOW9rtZCXthdnYB9vkjvG8Fr/73cEwkIoGOVEU7iV471FnrIWh5WCEKABXUn9V1+vsRnCQysR8N2NfYDyHlxKvtmcW3cXFN9hWTW5wQjph0THKAWBWiXJmqd4RAgdDVJ8OqBbKVtf1NVpqjDJfIX/iOtOuMB6s3V3mXkBeRh1UjzDVJr9eUZ3kQtGeHfyEGW1GD/pYg7/oyL8Kkr8km3HlxHf2QV2VQuI9ODuoyfDr7zkq1kHGT5bZn4MmjokxP7hi+vZYn8ZhOO7Q8H0m9AGl6wxhaJrdU3I1WlKoATJOAdCybKvWXKgWCMQsbwSjfcm1g+X0tAYZZPnxwuu9bHg4YbUiC0IpT3JIljBi6INPTvpjb32z0UcVI/4kc4adNJQRaiUtQvvJO8YMZTbbLCBT+ShiXPUEoFpE46cLSKTlzs5BJBUvnOsFjDB3XjsM7YHqLtUmtFa9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199021)(6512007)(71200400001)(478600001)(26005)(110136005)(186003)(6506007)(5660300002)(64756008)(316002)(91956017)(4744005)(2906002)(66446008)(66946007)(76116006)(6486002)(66476007)(8676002)(66556008)(8936002)(41300700001)(122000001)(83380400001)(36756003)(2616005)(38070700005)(38100700002)(86362001)(33656002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGNkUStRNzBwc1d3c0lreWsrU2xvblFyUzdkSHU0KzNHaW9ESUJZSkFka1gw?=
 =?utf-8?B?Y1JmeTlzTmV5VHVkWXJjZWw5VjZhVzh4MlVuMk5uRGx4bDFQWjRqbkxPMkZI?=
 =?utf-8?B?OWhFL3ZEZzFES3YzVVcwUzRtM1NpaHFkRHpMU3ZUOElTNVNnUFFpWHVXSTZH?=
 =?utf-8?B?K3FBdHpJSEFBOWZJUy81ZVgxQkpCa3g5YUtyUloxaGJBNVlURU1rK1M3L0Fm?=
 =?utf-8?B?bDZZdm9RbnhqNDArYkRzaWsxZlI3QTgyL2ZMSENCUFJsSEo3K0c2dnRJUUFq?=
 =?utf-8?B?YjUxbVFWeVRMeWZIaERxOHBxZ0NMYTN1YzduYU5zQ21KVnFoaEoyN1RXZ1B1?=
 =?utf-8?B?RjlTS0RZWmdmU3dDekZtTGYvOFdRV1Y2N3RUcHlyT2V3Ui9KeDFlczFNa1dm?=
 =?utf-8?B?UkRPL0xKOWJaVHBnVUFXWDduNkJ4RnEvYlo5WWdEbWloaVF2bjBCRC9FK3Rz?=
 =?utf-8?B?VmdmUndFc2RrVGZxOHZZQ294d2xWS2NTTklkUEhYYWZzMmhyMzlyOG42eGdz?=
 =?utf-8?B?dmVrSzVRVTZmb3BzMzVIcmxJbHZVVU5rS0lodTRGWEttYUFSKzhSR21SQUdY?=
 =?utf-8?B?amdrdU9wZ1NaSkROZVF3QzVoaWFnZU9EcHNPay96WXI1RlNUV3lNL0Q5VjFj?=
 =?utf-8?B?c2MwRkMyRDFFRG9aSDRTZVJENC9yS3dqbEJuWVltdDljRlZIZ2JOdzJwdXY1?=
 =?utf-8?B?VXRCS3JXSFIzSThVQ0pDY0pxSk10ZFFjZFJYc0FyNlMxWDFNbG5XNjBvN2w4?=
 =?utf-8?B?K2REbWgxZVBuaFVrNkdaYzE4TU5ha0VRMkZpcW02TWtkWGtzcTA5NzdqSyt6?=
 =?utf-8?B?SDF0VHVRcEp4SWtqbGhydXluM2hQM2p0MFVHUEtMaUp1amtFN1ViS0RISTh2?=
 =?utf-8?B?RHkrTW9ZRURqZUd5WEZ4NW9VZUxSUFltMlN0V1dwZTVJU0U2S1VaS2l1RFRD?=
 =?utf-8?B?WkFEU2lTMnYveFA4TTQ0Q1p2NHZ4S0lyTGlMMkpiaVgvbkNaZzFQQ2VuTWQy?=
 =?utf-8?B?Z2syL3RvUHBsN1owVzIwSWd1RnErTVJPRk5NcS96UzNyZlJwa2pjUDM0UTJp?=
 =?utf-8?B?U1F3Y1ZnSUMwZWsyaTE0N0liRVpGOExZSXBTTXpuSy9pTG1JS0FodGhUd0s2?=
 =?utf-8?B?RVBzclVZZG45Qzc2bFB5TSs3QjkxcjU4UjFNKzVYell1VlNGa0xVU242WEdw?=
 =?utf-8?B?clhXUStXRnVhNWtkcnBoQTMvemlzV2h1MHc3ZUwvdkI4b1krdENpUDl4Tzd3?=
 =?utf-8?B?S2t2em9QOHgwOVVVcVNwR3VjV0Y3ekJqZEx6eFVWOGtWREYwQ1Z4V3RSaWV1?=
 =?utf-8?B?SENMaHNFYmN0WFVFR0k5VVBBdUlXWm0rbWhCcC9VN0trWlV1blh2YVhqbEFF?=
 =?utf-8?B?MHR5czJsSWdLM0xvcFplVDFFUmRWcVFtbUJnOXRFR0E4c1dVVUZPSSt6a1N3?=
 =?utf-8?B?NTdnQ0d3K1FEaDBoSjV5dEVZWXN2cEwyV3JHZzdBSzhxS01TTnNmOHEwcDFZ?=
 =?utf-8?B?cHVYRnlUL3ovNjZzZ1RvNmc3N2tHbndhY3c5Vy8rTGdFODROQ3FraEtza0JZ?=
 =?utf-8?B?NEtvTnJuWkNCZ1loa09NeVFCZWJWblJXQm1kZDJYaXRFOWJvaWY5TGg5eXlO?=
 =?utf-8?B?UitSYzlhY3QxMkJ1WE9tcE1BaHdaZVlYUlovYTFIL0YzY0gzMmVJNzRqWlg2?=
 =?utf-8?B?aGRRTFZVNmdiY012L0FwVFZxcUhnMTU0QXlaZk9zK0VmS1ovWFFma0k2eUJj?=
 =?utf-8?B?UnRlSElHWkNVeks0YjErL1owVVRBa0JBS2tmaW4wQ3ErL25vUE9zeEFyclpU?=
 =?utf-8?B?a1VWbVdrWHpBQ0xqcm5JakhDMFp4ZjFFdjY0TWlHRHlWQkJ2dlZ6WS9uMmhp?=
 =?utf-8?B?THl5WGFOMUNSUTdFaHNaN1Zqc3E0K0NJN3IrSzcrU1FmeDIxcnZuNkdubjdy?=
 =?utf-8?B?aUtJQUI4NEVpbzR2dWNOd2dOQmxMREpMakZhVEQ3U3oyUUtEWkNxY01TeEJk?=
 =?utf-8?B?aVF1WWlVamRQNTU1RlphbXl6RFRiNjloOHJjUjhiODJFR3o0OHE4aTdXdVBN?=
 =?utf-8?B?YmVYRHhiczZraTh2S3pFVFZpUUxFMnRNY3ZVZ2xsV3NUbGdoZ1Q5ZlBlaS9H?=
 =?utf-8?B?Qm50ck1QaUpTbUdLK0dZaVNhTnd2S0VvV3JmLzVkUEw2RnZDTmQ4NkF5UWdS?=
 =?utf-8?B?blE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19767C3776B5794992A3A6E54270E817@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vB1nZ/yB5j70nrgC2d2Iaq/MCHD9TUGLFyyKjXDchA7kibkNhv9wBQy4u3jakL5tboL8ddvfbaezXzE5eVB+wNIFHFToKBq/NwrL6ATyI9ORJl3aQ/UFKb0hukqla259a1mFEpqCygkd4tiOKfQ4eI6i331UZR+zCWPOSwfJLMq3fucBYczuo9XqWtdvqYOMJBi3DBOG6DFsJ0BuWpAa5SA5lImM5xk5i1RdIcg1vl/PIn3I8GGHpMjZq3X07qXELDzik/+vXryb2kgF/mJRZ7yNNmg0csAGkx47iOETqLwxaHWGW4duNNA956sHgHMAJkpX/gUavmQ4JyE3F/f7PVaLA+UxKknbQGdfTHlm2uiWVEL9fUXx8BWQztDlSrrltEhrooYu6NY8RI9yTad3ZZ6zq8SYFsDG5MOSfhXoxB8UghTq69qLH6fuZ0TF4sfki9Mn5BhKXy/OHQikqjEg3annOleas0K88zxN+pC8q5GDvGk72ac8gQwHgxwLXZGIRl4u/2KT/xpRXDdsmReD0i77Y9GVquwzunfQisB9xuDEO0/KNxg1Lb9sFNvbCnJg3OzPqTOna0W1yugHYZGIlQJ6cEnJJHLvO8/zy69n4NwXiDCMdPo6Jig83/lGSi8bf9RQxNhu0GMiAKkFFm5P6o5wSZkf5ZtHPEPzbVutCZTBMW9B0oEvm64H3tabwNrnwncOsFMRgr4zZhFYnTa8HXIa1zLdaNMozGoGg2jnu2XO0Lghgk731yRpVZDOBj2wn2yw4pinB4JuMfBmYoqpoFsssCi6XuXuzl39h1e2DC5UJ6ryhWkMGWCorrrmS9FG4re0SPuEvF99CkkUm2yGjQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e61128-00f9-4aa7-b04f-08db3b8385cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 18:27:07.4393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wt9DdvyVQn2RgF2WnbcIKrS0Rqw8ccaolurBkaZdjFnYtdRZbODrj5MThif+VH9AnuMEaE60ipXfaFa8ObTL1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_10,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=975
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120158
X-Proofpoint-ORIG-GUID: nUtBP0ztrD19MDo8sSwf4sH8rDXoeZGt
X-Proofpoint-GUID: nUtBP0ztrD19MDo8sSwf4sH8rDXoeZGt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SSdkIGxpa2UgdG8gcmVxdWVzdCBzb21lIHRpbWUgZm9yIHRob3NlIGludGVyZXN0ZWQgc3BlY2lm
aWNhbGx5DQppbiBORlNEIHRvIGdhdGhlciBhbmQgZGlzY3VzcyBzb21lIHRvcGljcy4gTm90IGEg
bmV0d29yayBmaWxlDQpzeXN0ZW0gZnJlZS1mb3ItYWxsLCBidXQgc3BlY2lmaWNhbGx5IGZvciBO
RlNELCBiZWNhdXNlIHRoZXJlDQppcyBhIGxvbmcgbGlzdCBvZiBwb3RlbnRpYWwgdG9waWNzOg0K
DQogICAg4oCiIFByb2dyZXNzIG9uIHVzaW5nIGlvbWFwIGZvciBORlNEIFJFQUQvUkVBRF9QTFVT
IChhbm5hKQ0KICAgIOKAoiBSZXBsYWNpbmcgbmZzZF9zcGxpY2VfYWN0b3IgKGFsbCkNCiAgICDi
gKIgVHJhbnNpdGlvbiBmcm9tIHBhZ2UgYXJyYXlzIHRvIGJ2ZWNzIChkaG93ZWxscywgaGNoKQ0K
ICAgIOKAoiB0bXBmcyBkaXJlY3RvcnkgY29va2llIHN0YWJpbGl0eSAoY2VsKQ0KICAgIOKAoiB0
aW1lc3RhbXAgcmVzb2x1dGlvbiBhbmQgaV92ZXJzaW9uIChqbGF5dG9uKQ0KICAgIOKAoiBHU1Mg
S2VyYmVyb3MgZnV0dXJlcyAoZGhvd2VsbHMpDQogICAg4oCiIE5GUy9ORlNEIENJIChqbGF5dG9u
KQ0KICAgIOKAoiBORlNEIFBPU0lYIHRvIE5GU3Y0IEFDTCB0cmFuc2xhdGlvbiAtIHdyaXRpbmcg
ZG93biB0aGUgcnVsZXMgKGFsbCkNCg0KU29tZSBvZiB0aGVzZSB0b3BpY3MgbWlnaHQgYmUgYXBw
ZWFsaW5nIHRvIG90aGVycyBub3Qgc3BlY2lmaWNhbGx5DQppbnZvbHZlZCB3aXRoIE5GU0QgZGV2
ZWxvcG1lbnQuIElmIHRoZXJlJ3Mgc29tZXRoaW5nIHRoYXQgc2hvdWxkDQpiZSBtb3ZlZCB0byBh
bm90aGVyIHRyYWNrIG9yIHNlc3Npb24sIHBsZWFzZSBwaXBlIHVwLg0KDQotLQ0KQ2h1Y2sgTGV2
ZXINCg0KDQo=
