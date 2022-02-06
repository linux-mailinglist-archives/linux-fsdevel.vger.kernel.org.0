Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A064AAEBE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Feb 2022 11:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbiBFKAH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Feb 2022 05:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbiBFKAG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Feb 2022 05:00:06 -0500
X-Greylist: delayed 5428 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 02:00:05 PST
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E195C06173B;
        Sun,  6 Feb 2022 02:00:05 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21664ixo007379;
        Sun, 6 Feb 2022 08:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0TkGVljqEnY7cYRGGGQVx501/3CDDC0eUGvQA/vK7bY=;
 b=iH7pL8UrxbVyeLfYuShBKLvrzeat+Dz2hqwHGdaYJh6UCrCKWGYjRilHBsTZkaqP7FAF
 8afEGbKp+6s9n2VVHLkocvtacpW3FEZyp55sAJ7idskObx8ifuzi7p2bJrDKEE0XTose
 K2DVEhv4YL/WHGSLy+71EVtzlV57FsyU5ilw63DfHRUqKb1Q+hCaFdpf4w0yKZh3b25p
 KYeEDGqppbDRNNEqizXBHN/u0RBZhKhd6NZQTi0oE6etfuhy3iDHjioJKTj5wG1Pc/0u
 RL2hVoDocGGRRX5TqX72zAOskzQqdUMJ2XU5V5A5c2A2lUI2YQM7se9vaxfxY97BqcsC ww== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1gustrr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 08:29:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2168BeOe147452;
        Sun, 6 Feb 2022 08:29:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by userp3030.oracle.com with ESMTP id 3e1ebv4j7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 08:29:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8NOSOQROxxOpP1we112bENKkW9X0oic104gsR8w2ebt+GI8ywhKXXPCVmz4Q6MKOaI4O4e2S1kZI/UZd2TrbLfSJxR0c6KDrJeffGhQ40YdD6VwUBpU4Q64JkFXnoqAHaV3pLLJ2O9i9NZKiqDajD1a2/4GbHJ8BI7fo/y85pu9x1c1lavwKsDarGKQSoITebXc7F7WbXC44xKXdkURXp3tWyZ2xhSBg5Tng6RmV3jggJm6uyOAVC+SdmwpohtrGXjS9CXzYWlqZ94vH4aA5osETXvuVgH91/KnGmQCaXi2BIQ4OvMYNuSXVdOYiO4tkadUvqdkBQyg0vb9lVbMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TkGVljqEnY7cYRGGGQVx501/3CDDC0eUGvQA/vK7bY=;
 b=lNSkSR9PRv0Gmf2wshhkQv7Jh9Gm8SepnfiuRd8McMnugNYdwm04OsY4S/Xufi+1CQDHsb5Ba4K1c5lDhchczxSS0mN/Dq6L1nNqKmfQMCY65DwVRKf7kVLYux+oXXbvEBeniAzANfbvojPYHydkFY3eBcY1otokz8yx0JUU8Te2TKKaPlkmBcBdATKZjXs94r1dz1x0nSJGvvREZuhDz+nwAkwbVAcngV7jo61sqQRlBh0TPDfwfBDE8Y4ZMgM5yUvaWuSfdCKnjXqendQMwpuXE8TIykyFtu08x8f6Y1ZNXJ+DjR4x/DI/MNboP9yiCRtOROprPVHnrCPr/sMLxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TkGVljqEnY7cYRGGGQVx501/3CDDC0eUGvQA/vK7bY=;
 b=bws5bDOEYBsDpXqTNfAF8e8rqqYcRRRnsbgJk4WnBHu4XdN5q6GstLdP8di6bC1gP2GTLsKffe1B844mKdmpP/REmSIoVEWTYx+PIr77JMIVlDVLFw6TIY7kMsbk9/RePybRzIi6TXC8D79XJCk5p+P/8ZbnxApZOpmDG/+5kWk=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BYAPR10MB3174.namprd10.prod.outlook.com (2603:10b6:a03:159::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sun, 6 Feb
 2022 08:29:16 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%5]) with mapi id 15.20.4951.018; Sun, 6 Feb 2022
 08:29:15 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
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
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v5 2/7] dax: introduce dax device flag DAXDEV_RECOVERY
Thread-Topic: [PATCH v5 2/7] dax: introduce dax device flag DAXDEV_RECOVERY
Thread-Index: AQHYFI6IEi37NS8sIkiGyAObMdfpFKyARuiAgACHZgCAARCGAIABBPgAgAAER4CAA1YQgA==
Date:   Sun, 6 Feb 2022 08:29:15 +0000
Message-ID: <7a5d4def-a054-a445-2438-2333df713e48@oracle.com>
References: <20220128213150.1333552-1-jane.chu@oracle.com>
 <20220128213150.1333552-3-jane.chu@oracle.com>
 <YfqFuUsvuUUUWKfu@infradead.org>
 <45b4a944-1fb1-73e2-b1f8-213e60e27a72@oracle.com>
 <Yfvb6l/8AJJhRXKs@infradead.org>
 <CAPcyv4i99BhF+JndtanBuOWRc3eh1C=-CyswhvLDeDSeTHSUZw@mail.gmail.com>
 <CAPcyv4hCf0WpRyNx4vo0_+-w1ABX0cJTyLozPYEqiqR0i_H1_Q@mail.gmail.com>
In-Reply-To: <CAPcyv4hCf0WpRyNx4vo0_+-w1ABX0cJTyLozPYEqiqR0i_H1_Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 700bcb9c-dc41-4a85-6390-08d9e94ac31d
x-ms-traffictypediagnostic: BYAPR10MB3174:EE_
x-microsoft-antispam-prvs: <BYAPR10MB31741E12E04093CA556EE490F32B9@BYAPR10MB3174.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eYO3dqNF/y+kjUASndn59QIPtlczk+1BwOfd0g6O8Sl0rE9Jf0+verZO1gHiCoysqtfN/hqi62DyC0HLur2rBbJR9NNU1Bt3QXhiX6fZy8s/Hjg7Sbzkqg61Tl/ZrwW91N5iIlfAoGQ2PNM71MrsL1u8NLIU3Sz6rHFEp5Gs0ejvwyE9N/MkZZl0xtn4Zv9Uu+gld/kwewRMnSDI0jaTrTHNaM+x/MOt6QTBFH7x6wkrYyBtvDh+jm8Y9LS8IaBPEydl6J54mPauEEFadl9Z4BP2i/gpA/9vUWuujxBPvQII7Cc0iVFahd/sUTCvkmh/rSdTiXeUciJVN9+5ISNIIWr65ssTWzSl4e3I34SqYujL0eTLyLzCrjXzgvSpusotHDCt77wKef6bh2ORjCYKh9ZCPHDzjByoCVnBQZGR3R5pvo5QwayUgVD8mRzZawai2XTRw4rqjwoVTXB4s+FWhgJSxAhTGhYgJzsCB+SCc8FWS0i5f9qnDBpArDYtOo5KGRouZQn2NuSKutXuwSZkUxi8b6VVX+lo3F+ELANnwwKJ5RpyFyU/DowCjiGNWOVWQgs6EkGD5jbJTJymTSbH7eoYT0Yxug7oNmBr/gNHwuriCR32X85ikhqqtcKdP6/xDnR7etxr476eLiT2dAqLghY9QFqHCj075iJdmQVW1rCRurG1VVLIIL1TH28NDbAn7+QVH03GApofvdRnQ9xsj6PGaEHegkJ0Fuk++HgvWGlybuNY3QV41FRb7+JbOhwTUGWD1FbNkkQl5RdM5cgLzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(26005)(186003)(316002)(6512007)(6506007)(54906003)(71200400001)(122000001)(38100700002)(2906002)(2616005)(31686004)(53546011)(110136005)(31696002)(83380400001)(38070700005)(86362001)(44832011)(66946007)(5660300002)(508600001)(7416002)(8676002)(8936002)(4326008)(66446008)(66476007)(66556008)(76116006)(6486002)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXhsVHMyU1JUR3FEWFp3RTRJa2ErMFUxNzMvYmUzaUhudmkxZU9CdW1Nb3JO?=
 =?utf-8?B?ZXE4RUFsNUovbTVSNlpOTG5pSG1YWG5PSXNCeUdQMkU5NmFCV0M1WWRiYWk4?=
 =?utf-8?B?SEg1MVhxVG1Bdm54a0wvSlQyMDBSN3BqY2FuaFFKR1gxdVRSSHk3V09OYnlM?=
 =?utf-8?B?R1l6KzBXUmxxcFQ3QkMxdk00WE1UTCtieFdpekJablVhNzFpN0xiUlc3Rk03?=
 =?utf-8?B?SmVSRHR5RnVmZmJKQ05uNWZqSjRHTW1MeGh4SVd3a3g5c2l0M0RkZjJDVUpD?=
 =?utf-8?B?eU13a2h0cFFVRFk2UWs3YmxzcW5RN3BQbEp6dWpSejF4V2ZzaUNhblFYMlFE?=
 =?utf-8?B?bWc0empGS0IyY1ZsT2J0R2IrSUtJeitQU3kyM3AybnF1Tit4OUpSUzlCaWMy?=
 =?utf-8?B?amwwNW9ici9IL0Vqd1J3amNacmJ4KzZHbElHNVBnZHp2RW1TWGladjJtaHdQ?=
 =?utf-8?B?STBLd1lMTFo0VjNTWUIzdkhKamlRMldBOU5nR24yOFhMR1NNa3ZsWjBUQ3k0?=
 =?utf-8?B?ZmhEMnJrRW1ZVjFlU2svMVl6MjhjQnQ1MkM4VDZNT25NV0JxN2pSWXRDem4x?=
 =?utf-8?B?TWI5RktaeWs0UkNDZkNGVk1ydEVWSTZ0NkJvTTd4bnRFQ0pXUDRjQWhWdEFM?=
 =?utf-8?B?QmhEZmQvYUxCd2tPeE9aWjB2eE1pb1NmWUtTZkZaVDllVzVZbERraXBRY1cy?=
 =?utf-8?B?WTJoK3NEMFhYV3hNNDdkbm5PL2JaSlgyK2I0Z1QxNjhMNjN6N0RzRVU4Yzht?=
 =?utf-8?B?VXVNSy9wSUVMMFRvNi9PWHhYdVVzUTZQK3RmbGs0YzRHdXBIcjhkQzZ5Smp6?=
 =?utf-8?B?UjE1K3FpSkhITk90S0s0b2hBTVBRZWhPODhjZmliL3V4bmNFTElBUHRRTWRR?=
 =?utf-8?B?TFNWZTZkMlhXVGVTMGVhTWJZcWtsM2NSOFJNbUx2UEx6L05MUExsQTFDMGhL?=
 =?utf-8?B?Y2tlbGtCeWpCWWEvQ0E5RGhTM0dHQWY5S3JzSEpkZUF5cC8yMHN0RDl6OGJI?=
 =?utf-8?B?dXVNUXRJWnppSDNZSXM0aUk4SlJyRXhDL240eURpQnF1UlNPTzFuRUNhcDVj?=
 =?utf-8?B?V0V1Z2h5eTkyN1UvcXpqdHpSZllLNkFqcHhIZ09aVWNCQmRsQXhRaXM2YVNN?=
 =?utf-8?B?RnVYbFo5Sm5mcWtYVDVpREpDTmlRejc3OGo2eDVHSnc4MElVN1didG9zZmtv?=
 =?utf-8?B?TVlmUkUva1JUdGVyb05ITTVZMlI0aGVGVkNLR2pJUmdpYisvMFU0YkJWM2JP?=
 =?utf-8?B?WkdrZTdhNFdDTGp2cENFNzFaUXlFSDdQK3FRdkVSOVlIYmJBdkthbEFzYURS?=
 =?utf-8?B?T3JDRUJTdUtkTzNzY1ROWXBGeHB5N1VKRXkvVExOSGxBdjlTQ3RtZExkYkRM?=
 =?utf-8?B?Sm9QcEx1Y3VnYndseFVHWHJrS3FBc3R6VGY0N3JuV3U5Q0VOWkdvNVRzaEs2?=
 =?utf-8?B?TFlzaWVJMjdodFZDYko4NUFNMTJtbFlpamZiNG5oMGg3MlZOazl3bXRYMkFh?=
 =?utf-8?B?TUNnWHEyRWpwb1R3SFluanN6OUZnelE1OHBnekFpbkVsUUVmQkxXMlI1bzQv?=
 =?utf-8?B?YkZzWjFDbmVTV3pwWU1kbHlOS2RYOSswa3V1K3JLclNKWWszbVNGUi84Tks4?=
 =?utf-8?B?MVhMWlNKWllYbHd6UW00ZlpNNTBvRE9NTUIrS0JvSjkvWi9FZmtQdkRxSU85?=
 =?utf-8?B?ZDhtM09UUUdNdTlycEkzUFBZcS84VXVHNS9yUmlTWHhka3ZWaHduNExsZ3J0?=
 =?utf-8?B?bFcycWl5cDQ2a2k3MlF6TFFzbk5LMW9aV3l1K1hiVkVCZnNmV3JnVFRmdGJS?=
 =?utf-8?B?NmJpVkxCbzV0OHRRL3lZOXNDcGhadGFXVTk5YWgvMmFzUFFKSjlGa2MxVEh4?=
 =?utf-8?B?aXcwSlR6aXNTc2lkdGYwVGJGOUFDU2Y5dkNpUG43QmhTRGRoOWNWcTNSYU5N?=
 =?utf-8?B?RE56MkJJYUpDOTNhUGhMTG9TSW5aZWlEVE5PNi9WUlowSU1IdWpPYUtsL0x3?=
 =?utf-8?B?YlM4WG5aRDF2aUFqNTRnckVzWkMvMmVEbkVqaXp5V2VERmZGdU90RmVMZjRt?=
 =?utf-8?B?TmJIeURjR1IxR29iZnZkM2VzMW5mVW53V1VnTWV3eFg3RU9HV2ZuZFF2d01h?=
 =?utf-8?B?amFQVDlKcDZmaTNkakZ1aTFSZThMMkpqQmdwZmtIQUVYYzMxSjNDVnV5QXdj?=
 =?utf-8?B?ZFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <023C2240804C624FAEA4D47B24097260@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700bcb9c-dc41-4a85-6390-08d9e94ac31d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2022 08:29:15.7470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b11312b5djKxxTg/zo/uUDlJvrLZOVGmzHGV5Qq3eoQtI27d+xyF5jUqbDXYP0j+7dnV7CLH0KhfaeEoNW2ZKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3174
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10249 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202060060
X-Proofpoint-ORIG-GUID: GlKaU_tQhDs7EQpX2d8lt-3BgJxQyQjr
X-Proofpoint-GUID: GlKaU_tQhDs7EQpX2d8lt-3BgJxQyQjr
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMi8zLzIwMjIgOTozMiBQTSwgRGFuIFdpbGxpYW1zIHdyb3RlOg0KPiBPbiBUaHUsIEZlYiAz
LCAyMDIyIGF0IDk6MTcgUE0gRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+
IHdyb3RlOg0KPj4NCj4+IE9uIFRodSwgRmViIDMsIDIwMjIgYXQgNTo0MyBBTSBDaHJpc3RvcGgg
SGVsbHdpZyA8aGNoQGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPj4+DQo+Pj4gT24gV2VkLCBGZWIg
MDIsIDIwMjIgYXQgMDk6Mjc6NDJQTSArMDAwMCwgSmFuZSBDaHUgd3JvdGU6DQo+Pj4+IFllYWgs
IEkgc2VlLiAgV291bGQgeW91IHN1Z2dlc3QgYSB3YXkgdG8gcGFzcyB0aGUgaW5kaWNhdGlvbiBm
cm9tDQo+Pj4+IGRheF9pb21hcF9pdGVyIHRvIGRheF9kaXJlY3RfYWNjZXNzIHRoYXQgdGhlIGNh
bGxlciBpbnRlbmRzIHRoZQ0KPj4+PiBjYWxsZWUgdG8gaWdub3JlIHBvaXNvbiBpbiB0aGUgcmFu
Z2UgYmVjYXVzZSB0aGUgY2FsbGVyIGludGVuZHMNCj4+Pj4gdG8gZG8gcmVjb3Zlcnlfd3JpdGU/
IFdlIHRyaWVkIGFkZGluZyBhIGZsYWcgdG8gZGF4X2RpcmVjdF9hY2Nlc3MsIGFuZA0KPj4+PiB0
aGF0IHdhc24ndCBsaWtlZCBpZiBJIHJlY2FsbC4NCj4+Pg0KPj4+IFRvIG1lIGEgZmxhZyBzZWVt
cyBjbGVhbmVyIHRoYW4gdGhpcyBtYWdpYywgYnV0IGxldCdzIHdhaXQgZm9yIERhbiB0bw0KPj4+
IGNoaW1lIGluLg0KPj4NCj4+IFNvIGJhY2sgaW4gTm92ZW1iZXIgSSBzdWdnZXN0ZWQgbW9kaWZ5
aW5nIHRoZSBrYWRkciwgbWFpbmx5IHRvIGF2b2lkDQo+PiB0b3VjaGluZyBhbGwgdGhlIGRheF9k
aXJlY3RfYWNjZXNzKCkgY2FsbCBzaXRlcyBbMV0uIEhvd2V2ZXIsIG5vdw0KPj4gc2VlaW5nIHRo
ZSBjb2RlIGFuZCBDaHJpc29waCdzIGNvbW1lbnQgSSB0aGluayB0aGlzIGVpdGhlciB3YW50cyB0
eXBlDQo+PiBzYWZldHkgKGUuZy4gJ2RheF9hZGRyX3QgKicpLCBvciBqdXN0IGFkZCBhIG5ldyBm
bGFnLiBHaXZlbiBib3RoIG9mDQo+PiB0aG9zZSBvcHRpb25zIGludm9sdmUgdG91Y2hpbmcgYWxs
IGRheF9kaXJlY3RfYWNjZXNzKCkgY2FsbCBzaXRlcyBhbmQNCj4+IGEgQGZsYWdzIG9wZXJhdGlv
biBpcyBtb3JlIGV4dGVuc2libGUgaWYgYW55IG90aGVyIHNjZW5hcmlvcyBhcnJpdmUNCj4+IGxl
dHMgZ28gYWhlYWQgYW5kIHBsdW1iIGEgZmxhZyBhbmQgc2tpcCB0aGUgbWFnaWMuDQo+IA0KPiBK
dXN0IHRvIGJlIGNsZWFyIHdlIGFyZSB0YWxraW5nIGFib3V0IGEgZmxvdyBsaWtlOg0KPiANCj4g
ICAgICAgICAgZmxhZ3MgPSAwOw0KPiAgICAgICAgICByYyA9IGRheF9kaXJlY3RfYWNjZXNzKC4u
LiwgJmthZGRyLCBmbGFncywgLi4uKTsNCj4gICAgICAgICAgaWYgKHVubGlrZWx5KHJjKSkgew0K
PiAgICAgICAgICAgICAgICAgIGZsYWdzIHw9IERBWF9SRUNPVkVSWTsNCj4gICAgICAgICAgICAg
ICAgICBkYXhfZGlyZWN0X2FjY2VzcyguLi4sICZrYWRkciwgZmxhZ3MsIC4uLik7DQo+ICAgICAg
ICAgICAgICAgICAgcmV0dXJuIGRheF9yZWNvdmVyeV97cmVhZCx3cml0ZX0oLi4uLCBrYWRkciwg
Li4uKTsNCj4gICAgICAgICAgfQ0KPiAgICAgICAgICByZXR1cm4gY29weV97bWNfdG9faXRlcixm
cm9tX2l0ZXJfZmx1c2hjYWNoZX0oLi4uKTsNCg0KT2theSwgd2lsbCBnbyB3aXRoIGEgZmxhZy4N
Cg0KdGhhbmtzIQ0KLWphbmUNCg==
