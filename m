Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2E150AE9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 05:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443813AbiDVDuy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 23:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbiDVDuw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 23:50:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B1F4E39A;
        Thu, 21 Apr 2022 20:48:00 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23M16hUR011984;
        Fri, 22 Apr 2022 03:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vK1aqTdMX8wXdHtr+A+ZMFkhPd4BMQMvb2hLRd8uxQI=;
 b=R9ki9TDPbm+t3vrC02q03U8ipc1UXi9o5EFthRpJVpixl/HlnH4MKge5rrfmherowzly
 3Ufm9IJUJRJtFjCr/qPJB1TF1Ycfv79IhTIgbxVkaUgXPTOrfyp7o+mGiQ2UnPE0vTrP
 KIiSKvV4tAQveLfmEoHCavgvtYZTK38/O7GRI45ONEa6Y8fE1x+QtAx3FOn6zPJmjrO8
 1bpyfyli/xtpbbfXAuDRguFjJ9nDpbghlAm5ecqf3hus7jl+7+kwFcjj0h3oKoa0KnN7
 apuZePbw1a+CbciZGemwesmGNZscMAPeCtnDKDdHvR3X+qvDkMbRtDDA0ijGNnJ55XnK Jg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffpbvdxn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 03:47:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23M3jvi1022066;
        Fri, 22 Apr 2022 03:47:44 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2169.outbound.protection.outlook.com [104.47.73.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm8cwke3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Apr 2022 03:47:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCdA4/JfVPEVdVgi6PxNnGGQQy4RcRssvh/gUSLN01TZWn0iAp6YHoWW0Ew/EMCtHTwOP7TR+HpYV3Jy5EH5evn9EQDkVUe1GlHsajEw5F7tTQnMM7cNYaomWvVJexky6Bq5D15oM1GVrX6DVNtnCWpFdxSqojTa68pr+jZMaRRAKgo3jSD4Ee6muCXsGD1o7xkC+iE5Yq5MGD4IROE5lbYG1X7IegPkz6UYavY15/v5Gx6so4l6BhNCm0vQmhR5qrfqs/mdm2vDlzfQO86ghZGEDPDpmm00cMopvfgiON+wv+YEMYIGJibRFIZ/H2WPdPelgWHsjKU69yNyM0pq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vK1aqTdMX8wXdHtr+A+ZMFkhPd4BMQMvb2hLRd8uxQI=;
 b=MQC/uQ4cYvVlqv2fsjr+jXG971/6EvC3Dr6q7h+daVpWUFUzadrTQ9n/0pc89XBSPSdkbMgCdnCfyh5Ew1KhQJLvy0/wIsIfMtOLl0bl86uq3ntX8WPH/MK6mW+PEt/MRERpigRcnGc24s6xfBnLXucP20V8n2q2SUax+1ESjTyXxcnopF8v+0Mcd8w+J3u5i02wpIwTOd8du5KAhaD5GiWmPXFOhkUj+QiJBiVKhL0L34LeRfNIQOUHNgtjNT2kuiauzzW2zW/fhVDTFUvgp6T7b4JUuirOTZ49YsRLJX6EOZqu4UEN2QFR3qgaH6vaY2MUs/zI2NszOTVjL2x2pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vK1aqTdMX8wXdHtr+A+ZMFkhPd4BMQMvb2hLRd8uxQI=;
 b=Sbn77pLdjWbSTm12rxG/aamJVRz241spyWKgI7EDZWMr3/GeUZpTgVsy71RzDKfGYANYuk38mAl0YAE7UOjS8WX/T0wuJNeOSF1E3Lc4j8ln4z3rGYokAu4WChUnZMPi8DNzwEC0OoKYE/gmf6S1Y254+2qnPNG7GRe0DqOrYsk=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by MW5PR10MB5762.namprd10.prod.outlook.com (2603:10b6:303:19b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 03:47:42 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5164.025; Fri, 22 Apr 2022
 03:47:42 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>
Subject: Re: [PATCH v8 3/7] mce: fix set_mce_nospec to always unmap the whole
 page
Thread-Topic: [PATCH v8 3/7] mce: fix set_mce_nospec to always unmap the whole
 page
Thread-Index: AQHYVFsOIwXHXr3Ul0O3E7aDqkyM0az5792AgAFe3AA=
Date:   Fri, 22 Apr 2022 03:47:42 +0000
Message-ID: <4a27da28-062d-00e7-3da2-ac88f341abfc@oracle.com>
References: <20220420020435.90326-1-jane.chu@oracle.com>
 <20220420020435.90326-4-jane.chu@oracle.com> <YmD/CwS8AsbiC3af@infradead.org>
In-Reply-To: <YmD/CwS8AsbiC3af@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f575cbfb-2de6-40f5-cf23-08da2412dae2
x-ms-traffictypediagnostic: MW5PR10MB5762:EE_
x-microsoft-antispam-prvs: <MW5PR10MB5762EFC5D712FC90849C63DCF3F79@MW5PR10MB5762.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QMTXgSUiMayvV9Y+UqlGCT3G/DkNNFgaKvcnJqzGqawEhXRG7axayGz66qyzovJ4MKmvJYH6R4SmohO+B6PNP+4MR4Hdl9OBckcqnMbw7u2rtB8REzROTKXV+s55v8D9Hbz/IzqQkvUZ7v7cX5NjUjpUStIYKkTcPFltMmG4A+RHs3qvF7RQ2t9ffYgXFCr2RMpBbALTsMqDCCkxqnJffec3lTYDGz9hpP3JoY8DM0kqOXZHUUiclKFi+hxSrbHdLep2ChBHm43DHP2TLM/LPvoNgyBj7GcEVTcJctuJ1oZFYP93w55yRZIVTwAR8jhMmDF+Nszb10J4uid37bPJ5DtVbhnDUnNXwW1YTXLiTxKxpq0roM6rV5FjQYBgOV/m/gM8td7/a3FfDhWyxOxmPD9hQ/u+ryE1gzm0kcCgYfOjLL+33PZhBrpqafIMMazLOxxR4EJAfqHDsl5NG77Bc8rlB4Ah6q7fpU/qN3940D368PlTtL74EQJntozeRUNIZZe05mXtYeUGAE3SqnfG7/lErzqtvnbYTjor8a7895OYkXpECmgo7XqZtwRwm1zV38YhxlACOV2r0X1oTIGcH/HhzmrWU+AkG8SAwh38jm6lXlHI+4JBpdyQTwJoxIZX5WEHtG4H9hmuEW6HhENiqiyp6Z+1ThjvhEDM9wkT5awlK8cIIkuzh95FColTXdBlAh6sg3tpaaEaWzy3YB8EgYpX82n59Lt9O/Fy840Wew+RSFGT8TGGXjdNUV/x28CYllq3fiyxcve4PQoPlIUG0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(26005)(6512007)(316002)(558084003)(31696002)(6486002)(38100700002)(38070700005)(4326008)(508600001)(71200400001)(5660300002)(7416002)(64756008)(66446008)(8936002)(66946007)(76116006)(122000001)(6916009)(86362001)(186003)(66476007)(66556008)(2906002)(31686004)(53546011)(6506007)(8676002)(44832011)(36756003)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmNqZklUL2JWRVR1L253QkNoVWZqbVpyNjBJZzlqUzgyVEMydzAxV3NhNmd3?=
 =?utf-8?B?VE54NWFiWG1iU0thSjlZTVhBZFIvNm5vaXIrVk9EYmtLdXZnK2VKUjNzY045?=
 =?utf-8?B?d2RDSDN5aVJSMkZHRnR0UWZiTzlWbTBKb1hxUk85YlpWYmYvR1BGUU1hbkhG?=
 =?utf-8?B?SUJFa2dJcFI1ODcrV3BpeEUwT214OTZtWk5JYlB1NVFrc0NoQ3dRWGZ0ZUZ1?=
 =?utf-8?B?ZU1UakdnVlFkQmpsVDEzTDdZZkZPeGdPVkRudWVuY3QxaXBzT25QYmxOMnRB?=
 =?utf-8?B?NnNBTzJBQjh2UXVoZkdWeEVnTmt2MFA2bTRZVzJmZFJKUVl2NkhUQzFzSmVZ?=
 =?utf-8?B?aExQdGJ6SmVoM0l4TktsckV3cEVZV2M2djlncnNWU3BYM0lTS2U0V1FINi9p?=
 =?utf-8?B?VjhFTENucUpmYS8yQWE3U2JBLzJRV3gwaTJWd00vbjNSQTFnSVVUMy8xQm1a?=
 =?utf-8?B?dmdNSmlER1JNNzdNWmZHVjdVNk90TXRIL2VERUpNSXkyZyttVFdRWmFyZVFN?=
 =?utf-8?B?cTRpd242UWgvVksxVlhlS0MxeEdlaHl1NGNNc3pQQkR0d1k3L0JweHRLRnRC?=
 =?utf-8?B?UFFsNXZNazY0bDdTelBjRm9WK0tCMFFpUjdMYVg1TDNITFRjTUpXNlBMNks3?=
 =?utf-8?B?SDE4My9KMjA1ZlpxQVRsMEl6eUVRVStEemxrdkZSbUxqOUpjWWdwZlFwc3c0?=
 =?utf-8?B?dFo2c2RXODh3Qk9MMUpmL2gveDJ2VlVTYW91c2JTdW10MkVtbXBKeXFZVzRn?=
 =?utf-8?B?K2EwZitjYUU1SFpEalVkTW9BTjBhMnZ4cE1ZdytKcm1xVC9Td0RkTVg3NTJG?=
 =?utf-8?B?Y0ZoY21IQW9BMllZSy9uTENHWlBERVJHWUI0UVFTcDYyc2lCUDExRzg5a2pK?=
 =?utf-8?B?eGQ3QkZOeERZQ3JwaDFNSjlLN3NnWjNqRDBjcXhWZDlCc25yWE82MFlxVmhJ?=
 =?utf-8?B?OWtJeDRIR0FIYkx2d0p2dWNpeTY4Wkw4TmtWZitJWTluSUR1TUlINUlHR3Ex?=
 =?utf-8?B?TGhPdFM0aWlWREJkM2RDNkVRVXpBRFo5amtYbWNDanVHdkRCVEI2N3FBQkJ4?=
 =?utf-8?B?TEFuVitMRVpXUkx5RlRrb0NqWWNLaU96K2sxODdMdGFBazRtSnBUQlZpR3R3?=
 =?utf-8?B?VWR3R3l0SVFUUkEyRzZPcGJCWEt2YU13Wmc5ZVdlNXJRM2VqemZ0QmpZdnhG?=
 =?utf-8?B?Y2g4SWtEOVRGSFExWHlaOTRvbFRGaEVYVTF4VTN4cmk2MDJXNkN5bDBRYW1n?=
 =?utf-8?B?cy9vbkVXUzYybnVIVjYwV3V0RHhUdWMrVlgydSt3RHF1d01PMWVHNVZjYTJ1?=
 =?utf-8?B?K29BWnh0U1N0VVJhNHNIYlNxeWVROHF5TEFXeHM5Q1oycUs4cXVxYzdiY3ZU?=
 =?utf-8?B?TkdPeTFFR2pBZis0cFdET1BSV1hKdi9oWUI2blc0cmZpZnMvV0NlblNIM0Fn?=
 =?utf-8?B?OW16ZlpJOGc0Rk5tWDFpMlBqdmtpNkhNL0ZXaUc4Wm9CSmVIQ3c4ajFWMFVo?=
 =?utf-8?B?QThKTmFJYjF5WDVaY1F4Yk1RUmkrbS9TcWpJaGVrbXFQQitrM1ZqYjU0MGdw?=
 =?utf-8?B?VFNsTmg5Nkk2YmV4dmVyQkdhbGpEWENhSEh6cU1LL1BVM2ZMcHdoOWdLUThW?=
 =?utf-8?B?SVdlNUtNZTdQVGFtL0lpNFdFaENFRU1VSFlYNklkQmNqWE5pc1I5dllrckV5?=
 =?utf-8?B?UDlacEZ2Rk56MHFSd2I3cW5BYlZWYURyNWpyL2JUNWwwZWlqTXkzUDhOc0R2?=
 =?utf-8?B?R1RzQXAweFNUWjBSbEhieEMrTnEvaVhoNVlyb3lXa2xsaGd1bDZsVCt3K0Q5?=
 =?utf-8?B?SjM4V1kyTTl2ZFVFV0Y5WTNzblFaWXd1cEdsUGtsOW5XV1M0SE9QRFdhOStw?=
 =?utf-8?B?M2wvajZvSHl0eE5xVTBLcjNnK2hoMWdtMEhyNC9XUTQ0VFhLV3h1WjlzZEdT?=
 =?utf-8?B?T0x1czZkdGN6bkIxZVRqS2xReUVUWFlUK2dSMGpxcXdMNkxFdEFSN1N4QUJ5?=
 =?utf-8?B?c3VxajZWbzZtYkloWEZWTkJZYVFyTUZjQk9YMUo3RndoTFJOQkRBSDN1eWxS?=
 =?utf-8?B?NnUrcWZqcEpXM2dWYjJ0bXBvbUlPSHVyRVZXSnFRdGxlMnV4ajk1V0VHdlNw?=
 =?utf-8?B?cGQrRlowbGFZeERDcGY1R3czUFREUFpIRkRNVTNOdHdHNmJtTVNzRXFZS3d6?=
 =?utf-8?B?ODBsS0dGeXVVd2dhMnJMbThVdDdyTS9pczU1UkRON0E3cE9xVUVIVGdUZEU1?=
 =?utf-8?B?THRraVNHZlJYajZiNVBIVVdvMmx5SnFCVktLam1XK3Z1d2RMM2R4b25IcjdU?=
 =?utf-8?Q?TFOigl5WzXHZLrSiz9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8E43209FDEEFA4DA8BA9C3F09DDBD31@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f575cbfb-2de6-40f5-cf23-08da2412dae2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 03:47:42.5561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hTDjun1V3N4zeIEOUZhm2/Zn3LGF95/N/20EAIUYsmwHV7oFsGddHd/GgJQp3xk2o7IC5miBF6SprJmTw4nNCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5762
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-22_01:2022-04-21,2022-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=895 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204220013
X-Proofpoint-GUID: VoBHWzK3rf6oyT-qSru80hUkV3vaQZb8
X-Proofpoint-ORIG-GUID: VoBHWzK3rf6oyT-qSru80hUkV3vaQZb8
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8yMC8yMDIyIDExOjUxIFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gTG9va3Mg
Z29vZDoNCj4gDQo+IFJldmlld2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4N
Cg0KdGhhbmtzIQ0KLWphbmUNCg==
