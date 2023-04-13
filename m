Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22E96E13B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 19:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjDMRnf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 13:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMRne (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:43:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B5719A3;
        Thu, 13 Apr 2023 10:43:33 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33DGUOZA010170;
        Thu, 13 Apr 2023 17:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=TcqCzRe73lxKgCYYLreer2MrHRmhgj+FLUlCnrUfHf0=;
 b=3P1MC65Xgdg75jjT25Mo+GFehPVJqG+La9fEv3/UdKCfmMT/jKoUUIAAohdyF5gM+LwT
 Y4t/a3fYY6hXubdYBcR1cLwPfxnxTzIISzib6L7wfSQsWvttkAjBOu6ow6z59Yukg/XF
 87JUa56rHFccoJ56zVYwjUY2Vr9yqRbTQ8dL5kPDZkU80oZdKjt2YNiTIgGBc2uoSOwP
 YV2C8k+Uv9FWEneR8SakU43+F35Dvakgzn5/NC5m9vjclIN9zMoc8z43+qQYEouA9XV4
 dzYoTECJWHeQV4hxiy36gT6qNt++IU4k6yBRERwtmLUk20ttUD+G4xcNSJPcs/mF3KaV fQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0bw3v9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 17:43:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33DH5CuV017532;
        Thu, 13 Apr 2023 17:43:29 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3puw8ausam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Apr 2023 17:43:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VA4DjiyNtUTg0yoe1QDJbUyIlAclj5zYhHPihivpqDSNwNex4yLnWSxjUbHQsFGOy0R7hsiBCpBSX29BnNBTSSlFONxx9jfgthRpqWLcDQB3KNtlJCv+fvaD2Vcoq70sDamYQqEY6m9GJOBUqnDWcvVsyHhsm3yCMdBpOa9RcsN8VPeZXmo5tNtbKxSjsCNK3N4DHiV1g+Bhrg4x2EsiL1dExknT59HCE8bpJC99pj2lay3VTAIf1ZsJXAyyIuKFRd7aCGQgYTlS/U3ttzr2QBPAv5ryfJM+V21dTs9oW4Or0DBxwZpzcWllaHFSdAxE1l8FsUrqxGsUdKk7FmQDQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcqCzRe73lxKgCYYLreer2MrHRmhgj+FLUlCnrUfHf0=;
 b=Z7seBUdW7VLORYpRemk/d+FLnrLaV5CeGVzAW4tZ2+ngNrEgbThIZQdhr7o5C9q8eYzgcqZfQ3x5jd55cQccF+yCIcZtG8Kw6aUYnGRkuO74qDbzd9nNDoSf8nxC0Kb/NSvtKMs7wuR/74eNLuO96FnIg2JT2rBAXhgHrUh2yOOqOR/sf06paXFESlVXUdYHj0FhETnWiGNiAaodE0svHMOADQHchs3Ymc/yZtWWH5nr3Pqi16RCwH+s3S47a77Yob6t6S2xfMzeXBlFEo2LrLwPcWeeeeuP6ZdBp5O+/ehw7PJgE5A3i4JWwx9LdMEWySEeeDyc3zrHbvUCnGpKdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcqCzRe73lxKgCYYLreer2MrHRmhgj+FLUlCnrUfHf0=;
 b=SEcaE2uu2cpaZSwDStj+f8GODrTdIh+lrNsuM9mAIkx6HO7FVr2/FSsdQU/Lq602bDTgoaOoQ8gVqb3Grm6QVRV3z5FDu8r5ozRYaWeKk0fS8ZH5rCC5OI1VcYVX1mRQ4tByLboO6DWR96GvA95UJgEWqwnbl3jW05ghRdtCgVU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6686.namprd10.prod.outlook.com (2603:10b6:208:41a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 17:43:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%7]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 17:43:05 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     Christian Brauner <brauner@kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] BoF for nfsd
Thread-Topic: [LSF/MM/BPF TOPIC] BoF for nfsd
Thread-Index: AQHZbWxjHsN6sWZ220WWP7UeL6JICq8o+w2AgAA8ZACAAEx3gA==
Date:   Thu, 13 Apr 2023 17:43:05 +0000
Message-ID: <06ACCC98-6D54-43FB-AEF9-F346E92EBBB1@oracle.com>
References: <FF0202C3-7500-4BB3-914B-DBAA3E0EA3D7@oracle.com>
 <20230413-perspektive-glasur-6e2685229a95@brauner>
 <a486f239b361a6f03cf40c3762876e206c5dbfd8.camel@kernel.org>
In-Reply-To: <a486f239b361a6f03cf40c3762876e206c5dbfd8.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB6686:EE_
x-ms-office365-filtering-correlation-id: 9cad908e-69f4-4667-e3ca-08db3c4689b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sBcqQphIl7nHrOPU+F2ABZPNA179I7oqeg2H1qLh6bLyL7W5j3ZBAJR11gr3MTeqM2i5TWQQsKSBhRQfhMKZccg+L4zt8uJ4fA0uHTlT1tzrQFPK4Z2QopN5YDq8iJP28PKNVpWcIyR3D6xvBWEYi6SSnGDA/mYZXcYHOq8ARvD9ih4gGT99cKWe5MOpgfIZ/gDpQ4SBHJYO2rGtVZBElCQWhXE5O+cFUdsIyeZeh4ohT+g/avWnU37euhvdS6UxPh6vbJ8QLJK38qR+GoxjpaW2fwlvQtek7y1UolKX3l5DnbjuW5/WphJVB3oVYL5DNlT7lBj6mReOd8c46IxW+kvIlkPnGqC7eETqtzidD3blQVIvF9r4bZnHgtgD/BLT23jsXgZHTL5dW9WHWgG2tK7rOVZFJ7ZE0Ton5vhSrunVFlG/tl2qFv+xX/SgFdiiTUXtrfZnd383GhDdyTSWcmuU6i03uViQx9mkx+sb4ZmxtKyEtOSI5gkbT7qtigzel3KOlzwuDSmaMwsJufZAoEzQlTSZKsfw7uDJ7SQyx+ay6RZSzL8MfE6QR5z0IrzO4avODNmilG15ymQaHd2/Oi5LAJ1//fA9x9/DzZcZLr6Fv1ZYFCt9CbbyOquboHTadYhoxPGPnLedC2ubGEdsEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(38070700005)(6512007)(6506007)(26005)(186003)(53546011)(54906003)(33656002)(478600001)(122000001)(2906002)(8676002)(8936002)(4744005)(83380400001)(41300700001)(2616005)(5660300002)(4326008)(6916009)(38100700002)(316002)(66946007)(66556008)(91956017)(76116006)(66476007)(64756008)(66446008)(86362001)(6486002)(71200400001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVRwYXRKSUdWVDdzT1NOLy9pMjNtaTA3bVovQkdSTkpYQjlRTy9IcnNSVklU?=
 =?utf-8?B?WXZ5TFVjbWZHNHBiVDNySldnWmYvTUV3dFZ0Wk1GTGhzQXUvMjZ6aDJPbFpu?=
 =?utf-8?B?M1BlQXdrdmR5eGUyVjQzbWlRSk5IYVJFMkp1ZWlGd01TUVV5Ui9SNGF2QUhn?=
 =?utf-8?B?NmpXMC91UFk5bzlCSVhsNXU1QmxuTHIycjY1eEhOQlY1RUlUUnpIcVNLeWJw?=
 =?utf-8?B?ZzQyR0J4VFpqZkxQVmhrcVliS2NONWNTME5tS1llbDF5VURiTFdxNkhmVHFa?=
 =?utf-8?B?Z3N3YjA0ZExlZjFpWDFnaW5xSjRlZ3l3c2JETDNucy9SS2RhMGxkNEFqMGNQ?=
 =?utf-8?B?TGUyZ1RrQWdpa0N5dFRLakF2dklrVXRFdXpuZXdNcER2QkZsRm5FWUFyWmRr?=
 =?utf-8?B?RTZjSXg4YTd1ZDRoYktiU3UvbXBXZlJwdDhOLzdlTTBwYTVkS0poNG15dlBm?=
 =?utf-8?B?R3Zoa1hJa0l4enMxVEJlWkhMN2p1TmtGWWVTbE1qNHducHFFeEkvTnI0YnhZ?=
 =?utf-8?B?Wi9pMFpPOTY1MW1JTCtEWHVHc1ZlM2pISzN6VnQ5MGtVTTZIaHVrMTNid1Bi?=
 =?utf-8?B?QXlDSm5aRGNwczJtSE44RitiYW16bGpvVU1OaDF6aFVoRDJ3WTJzNnFmdkV2?=
 =?utf-8?B?YnVobjJPbjdwVDhNd2h4d1M4eGVBRWFiZ25NaFJJNHBiUmwxVEdWLzE1ai9N?=
 =?utf-8?B?WUxhQjRXeENpRU1TaGRDSnBjSkF5YzhRZ21rb1l1VnIvZCt4Ny9sSnpFK25H?=
 =?utf-8?B?dVFoZFBTa3dnNFdkbVMwazdORWN1RVFnWWc2QXQ3UUZHMHNpZEgxdnRoNUJz?=
 =?utf-8?B?d0RMekFFcllXWWF6ejlpamZpRVNkYzE3bk40Y0lINUlZSVRyZDhtSGxydmRI?=
 =?utf-8?B?UUdtLyt5MnBBcnlUeVZGblpCTCtKWlNwa0FxODlwS1lGSG5QajZOK2tGbFZx?=
 =?utf-8?B?TEpjbkxITkJqeU03SnhKanJzSkxsVitFa0txTXBoQlYyazFBTWJCdGIrL3Yr?=
 =?utf-8?B?clJCdnFJM2dqY2hzV0lhcDRIWjZrQ2RVVzJ6eDJLNWdFUUpsejlBMUlLZy96?=
 =?utf-8?B?ZHZEQ2lOdm1QNUo2VWQ1UFByV0FUOGJYSVNSdzl3MHA1RFB5RmRhTlNUNCtQ?=
 =?utf-8?B?ZnJ3VkQzOTJ0bENVMlpVSTdPYlM1NTlPclFHR096QU1UUmdoOUJQeGtsOUUv?=
 =?utf-8?B?akllNm1tWTZLS0NkekQ2U2UxY3ZYbEgvNXlzQk9Rd0xGY3lJOENKdHVVUmh0?=
 =?utf-8?B?RkE5bmQ1N3dONERLejBCNWdjQ3ArUm1ra2tLNS9VSHVYeG1hYnFuTlcrWDk5?=
 =?utf-8?B?WkJkajZDRXJqUlBoa0poSGQ0UkFnRk95czEwTVdiUEU4NVVrTndKcFcyYXRL?=
 =?utf-8?B?S3QraTBBQWJ5QTJJTWtMdUxtOWgzVHo1UThxczlBTGRLUWpVRGRsR2V1NThp?=
 =?utf-8?B?Q0sxUjNHYWRpdUwvOHBNOXU5R1Vhc2QreWZQK29mVHVuV3hUTndqM1ZFTVJt?=
 =?utf-8?B?ZnhTWmEwZ1NhZlUyaU1Ra2tZZThCbHRRbVNnQ2h0dnVpUXFaSTdncmJLeGdi?=
 =?utf-8?B?MmgvcWI1N09oN1NJaDRxTDNmTlVkWEFkdDdUdU15dVUyZXBZNG5rNkxIQldk?=
 =?utf-8?B?MEpobnVKd1VBaWdMQXZ1TWNuVnJaQ0VEZHZVLzQxMFpIaTRTTk9qRXo0ajNm?=
 =?utf-8?B?c3l0S2FqSE9WWE5VOWMxTnNYa0ZvYUNFdDU3Q1BocG1TVXVmc0JSOURZOGwz?=
 =?utf-8?B?SmM0OXRUbnJ6QTVnN3BXTmVFWFV2cmJxYXF4V3JtQlpSMmpWekdEY1FTMjc1?=
 =?utf-8?B?TFptcFVBald2Q0R0R1pSRGFDZU1ueFpNVitDL1VZYkhOM3V1WlhJSHJ5MXpv?=
 =?utf-8?B?SUFuQ014TXExczlrSk01ZG5rc2d4VzRNVXZ2NW9yem1Ed3ZTRmFjZUdDWTBw?=
 =?utf-8?B?L29oZlgzZHlNWEhZaWl0ZzZqWkxZdlZDcXoyZ2xNcS9QK2xNNFZwVXFQN29a?=
 =?utf-8?B?ZkYreXFqa0dpUDZIUEdvZnE3M0RFVzhRVnNaMjJ0MHhvblF2NG56MVZzY05z?=
 =?utf-8?B?THVTaG1nWnpIZmIzWkZCeG9IUlREcFhUMVNnUWhqTFlYYjJ2enZEOEorbWZt?=
 =?utf-8?B?T3d2VHRGTmwxY3lKOUt6SkxVNm5NekQvVGtTU3M4N0NmWXRvQlF1ajE3cU1K?=
 =?utf-8?B?R3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <819993137404CE4EA69D1D9B2970E1A7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0uOO90J5Hshs54OcBtgKgrN+LQ3Qof5lyuSYz86JoyxD2tTTDu3bhu+qAZVpT+yHfl467b4o2hca1MW63qxoLI/eVRODsB+J2ZvbeDXp5RkhmxgoSnctkaSx6KRaBvzFSuCh3lGS7Tq1LfoLoGU3Ff63vln1a4qmawKKl2iBlZSie7onJ9rHXBuZrRF3XGpNRzDy+I/Wl/MkAjVAD/xettt9n/kcaR7hyacNDav5YmddJZm/O+p8OdX2wtZEeAKQ0iryJTAE0rnIykcUouW7TOyXZoCdc3zYRYr0MaH6S0qijv41AZ7VwyYh6b77Kli6GTkSaXSAhSmneLUTgMSgzS2YatXmkw7kixJIgffEJqKCpk/DuvVHZApH2tbRLX8u7VZptzTcBJ3HoDo9H1E68TR6FQorkWOMPZFkrn9jw2YO/J9v6fRGgQXk4QyavKPy33iqU7vhWLpP2q55z4Al/Z+fu83Rx0wWPxCDuLt16ekfn5jlp9UJDufxA/kSMjaKJgwu+i+wQYct/npv0e9B5ZbL4i3UCJfehU5mfhp3h80ZB3GWugb+i6+8NLMzaGqMDaftbh+4C9FYoE55RasKO0PrOK+GgfSgS6/iF+6YI+UL9rE7/eYZ4cBglTDHmybK5wI88UFuYjP5PFrkNM9dipukejVG3/dTVtXxBQGZo1wq97yb2kmvCGLvJSlxO3AkYmJ3yGCImibHYV6P2jjUB/C0DHlA7eQ1+f4acU53jUIAtZlDlm21ECYYLbtJlwcyLtd2rFXVAGPiSZa7tIoZaVBTizzswS0j8YBFEssUYs20FjdVMH/ucbJ6pNy3APgw5hYawUSQMdYsjjxgNl/90c8X/Gea1h8pVne2hxUNAJc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cad908e-69f4-4667-e3ca-08db3c4689b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 17:43:05.8157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vOZZtO+rUoOr5zOgrCo4MSFEnGSC5uhuI+6Ig28P7wVQEy6bhZ5OryyCbEGvw0RjB/PaJKilueYvaSzt77NEAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6686
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_12,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=799
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130157
X-Proofpoint-GUID: E3KZ6XLmdCefSbTWb_O6ij3lRhXa2TW1
X-Proofpoint-ORIG-GUID: E3KZ6XLmdCefSbTWb_O6ij3lRhXa2TW1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gT24gQXByIDEzLCAyMDIzLCBhdCA5OjA5IEFNLCBKZWZmIExheXRvbiA8amxheXRvbkBr
ZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgMjAyMy0wNC0xMyBhdCAxMTozMyArMDIw
MCwgQ2hyaXN0aWFuIEJyYXVuZXIgd3JvdGU6DQo+PiBPbiBXZWQsIEFwciAxMiwgMjAyMyBhdCAw
NjoyNzowN1BNICswMDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+Pj4gSSdkIGxpa2UgdG8g
cmVxdWVzdCBzb21lIHRpbWUgZm9yIHRob3NlIGludGVyZXN0ZWQgc3BlY2lmaWNhbGx5DQo+Pj4g
aW4gTkZTRCB0byBnYXRoZXIgYW5kIGRpc2N1c3Mgc29tZSB0b3BpY3MuIE5vdCBhIG5ldHdvcmsg
ZmlsZQ0KPj4+IHN5c3RlbSBmcmVlLWZvci1hbGwsIGJ1dCBzcGVjaWZpY2FsbHkgZm9yIE5GU0Qs
IGJlY2F1c2UgdGhlcmUNCj4+PiBpcyBhIGxvbmcgbGlzdCBvZiBwb3RlbnRpYWwgdG9waWNzOg0K
Pj4+IA0KPj4+ICAgIOKAoiBQcm9ncmVzcyBvbiB1c2luZyBpb21hcCBmb3IgTkZTRCBSRUFEL1JF
QURfUExVUyAoYW5uYSkNCj4+PiAgICDigKIgUmVwbGFjaW5nIG5mc2Rfc3BsaWNlX2FjdG9yIChh
bGwpDQo+Pj4gICAg4oCiIFRyYW5zaXRpb24gZnJvbSBwYWdlIGFycmF5cyB0byBidmVjcyAoZGhv
d2VsbHMsIGhjaCkNCj4+PiAgICDigKIgdG1wZnMgZGlyZWN0b3J5IGNvb2tpZSBzdGFiaWxpdHkg
KGNlbCkNCj4+PiAgICDigKIgdGltZXN0YW1wIHJlc29sdXRpb24gYW5kIGlfdmVyc2lvbiAoamxh
eXRvbikNCj4+IA0KPj4gSSdkIGF0dGVuZCB0aGlzIG9uZS4NCj4+IA0KPiANCj4gSSB3b25kZXIg
aWYgd2Ugb3VnaHQgdG8gcHJvcG9zZSBhIHNlcGFyYXRlIEZTIHRyYWNrIHNwb3QgZm9yIHRoaXM/
IEkNCj4gc29ydCBvZiBleHBlY3Qgc29tZSBsaXZlbHkgZGlzY3Vzc2lvbiwgYW5kIHRoaXMgbWF5
IGJlIG9mIG1vcmUgaW50ZXJlc3QNCj4gdGhhbiBqdXN0IG5mc2QgZm9sa3MuDQoNCkZpbmUgd2l0
aCBtZSwgdGhhdCBtZWFucyBtb3JlIHRpbWUgZm9yIGJvdGggdGhpcyB0b3BpYyBhbmQNCmZvciB0
aGUgb3RoZXIgdG9waWNzIG9uIHRoZSBORlNEIGxpc3QuDQoNCg0KLS0NCkNodWNrIExldmVyDQoN
Cg0K
