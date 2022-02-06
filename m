Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AC54AAED0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Feb 2022 11:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbiBFKVy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Feb 2022 05:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiBFKVx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Feb 2022 05:21:53 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893B1C06173B;
        Sun,  6 Feb 2022 02:21:52 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2167Co1n027523;
        Sun, 6 Feb 2022 08:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ZUr+peSrHcMd1Nmr1Gw9tQ4Ei4QfgqW70Mfp5wXUg3s=;
 b=blVNlMrSQFuaYLHoUXy6lo9qXt+giWk2bsaaiXIRoTDW8tN+1eXpOlEyttAoD6/BqkhU
 unkRzeQqpmd215mkw5taFaPeBUXoOpOJGcp5ifefoeasLEPqM+ZzGiGY1nPQSZVGLAUZ
 hKV90e7DMRuNBRnMNsx25HiXcr36vHgjqBeV8DhHB7usvBFomA8evs20X7Vt5SSTJunW
 MNtuQLVcmSHpX+d8n/rA1Fqiq8Bn4cVVT3tPZBjiBLDJDUU+DNUZ3kcJHyzMHBlNV6Pm
 nXda7PGwDxnqhXDHTIAa+qfwHz0/tjvXw54jqtwls+YxFZe51h8QoZhC6th9zMvmS0Sq mA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1h4b2jjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 08:08:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21685ehS134146;
        Sun, 6 Feb 2022 08:08:43 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by userp3030.oracle.com with ESMTP id 3e1ebv44dk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 08:08:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScWwGOt/w5cgVMb6JG8mPXAoRMwYHZ4zjYGCEVI9jets0AAC4Sg7I3wNHjZVGKYSmDFJiRB8cOoKY0//ctSMeQPQCdP8TDsOG5wbQPCqt3UdY4latQQ1QKSL9MhU0Au11R6CfFiapuuWoayi4md/5r+EIHwGafAc0Jyz7MWvXsbI94gAyRp7+YxeNeXBh7imbWN3aviYGZYrGa/VqRhAVOv1KoL1Humf6zEX3Plo4OnL6t5OGCECm9AiisVF9ub7BLuPWxuRvbA3GFlDUbjFg5N67glU9Eii9xyXRW35ktoIVn0Fw5cQDUQ+jb+sNff6G/83tLTX4eRR+lH59rlGIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUr+peSrHcMd1Nmr1Gw9tQ4Ei4QfgqW70Mfp5wXUg3s=;
 b=b+WmDvs/TgEnI5F65hj31q/7L2l3UKG9+rbrGiMdmrgeKG11ebk8aexSSaAfP4us+sTOhoo1sYUHhJLuOBbR247jrX1B244AOoJiYfTRY26SYaegTki4JkIxLIQM2uVMOLvMkcmn9qtLmpki1r6AF+LdAEWoW/xLUdPKDtBWRReoXqff0obcHh/U89wyYsLBM2eho/tKWPS8KzfICCLGYYCvmd7UvpyI+K0qGjASHb5BdFSBbz9cKRHXczmg9lWzhTPi0XjGW0PBh53CCB6JSSQMmRPe6SzsHIeJYqUh+K/5VfGDwug8SHRFx8L6zwUcTI2UVwkeNLb4UU425aDATg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUr+peSrHcMd1Nmr1Gw9tQ4Ei4QfgqW70Mfp5wXUg3s=;
 b=jAatuSkywQb+/KvKLazhXGe6CCYs3Dx7hCFrsofTuv8yE9TIK/4edH7V3O9aDhuSIVyuJRilF1MQmIyFOx8J7+miaKUDyOqZorNXnalHjBrkCuoBN8f1/8RmZMqEEq09TF+DJTm9B5i42D5Z1T8oM9dubJHwJBXfw703X+5c9bo=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BY5PR10MB3873.namprd10.prod.outlook.com (2603:10b6:a03:1b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Sun, 6 Feb
 2022 08:08:40 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%5]) with mapi id 15.20.4951.018; Sun, 6 Feb 2022
 08:08:39 +0000
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
Subject: Re: [PATCH v5 5/7] pmem: add pmem_recovery_write() dax op
Thread-Topic: [PATCH v5 5/7] pmem: add pmem_recovery_write() dax op
Thread-Index: AQHYFI6Ncz9/iVrSZU2vUZQLJAd6lqyC9biAgANCqYA=
Date:   Sun, 6 Feb 2022 08:08:39 +0000
Message-ID: <06c5595c-45b3-a58b-74f9-6d2956d61113@oracle.com>
References: <20220128213150.1333552-1-jane.chu@oracle.com>
 <20220128213150.1333552-6-jane.chu@oracle.com>
 <CAPcyv4ip=JZXcQkDOtjcSsD=y7wRJEA0GdYSbx9+UrGCg8BNvQ@mail.gmail.com>
In-Reply-To: <CAPcyv4ip=JZXcQkDOtjcSsD=y7wRJEA0GdYSbx9+UrGCg8BNvQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2c0dd95-567d-4f0d-71e7-08d9e947e254
x-ms-traffictypediagnostic: BY5PR10MB3873:EE_
x-microsoft-antispam-prvs: <BY5PR10MB3873E62F167F2953C9740D6FF32B9@BY5PR10MB3873.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lDxd7c2FeMWEz3+W6T+QBNsvi47w04R1N2FTESSvnVF69wCg3HF/M9Z49ECke9V9uv7XE4qJbimQHmdmzS3CijnE2xQuSibXLWEBIxzqpkQ/vlBah7PreRq73hY+rd9+XQwZBd2/3dFwoEPRffclWwvBg4ruHD/5yHg1rnoCtKqaDq/lQSw3WIqC0Y2S+kUT4wdp04jeChHR+qQ/Jz/AuasIYS4gtgkRfZFW9eAnxkJMfPe8UIO7D8YU8mhw5oPvIA+DjL5vQqLOXuZKMLe/VVGr3u9dVzv+rUdZ+Z2TEW9ap5VPpDErTTWMZGAkDnjP8FgQqLEZ48/39eaCHlq16mQULwiwEOnwW2ZRpbYpKl1KxJ5pPj3H0YS6uWUUmOKDADrDgL3RQWF7jgaBpZflaEWlDs4nTKBruAyDyYHGgyHyJObAia81iSyeIa1/xcoYgjudET7luJIcinrXgegASYx7yzku2h9tJuMRJL3oU4+AT/pK6/ocbpTpFXsl4NV0U/MaFydTL6VsTfCmhTBrNFChFNffwlCW687rFp2pVAptya7rdzKTUL8Pzs6XBSSZbLNN/A+5DJuNu3e0uy8YSyzHbfP3ucIDcbW8e4N6gTGArQXuQskr9qn6/MfVVF1zhEbBae83HMDSpq3OLGfSCevnFKW3Alpp4ItBDmPI5KtkE6QLngh3eLvbbqLjTnmp2H1jX6+FGopaD4e/lTcWFeSawa+obi4niwz6zrdhrjHfq3v/QCWR3gQ1OoQcn9oKCgps+Gvlw2NB0S15bMEWbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(186003)(76116006)(66476007)(66946007)(5660300002)(66556008)(66446008)(64756008)(26005)(7416002)(4326008)(83380400001)(8936002)(8676002)(44832011)(54906003)(36756003)(53546011)(508600001)(31696002)(6916009)(6512007)(71200400001)(122000001)(38070700005)(6486002)(2906002)(2616005)(86362001)(6506007)(31686004)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OERPSmd4VnBZSEVFdFQzSHNDQVlBNEdySDE4bGJxK0ROU3ZZUE1rYWlhK2tt?=
 =?utf-8?B?ek1ESHJTT2NKNnZudUVTbXoxSGJHWDI1RmMzUm1wVDkzbjBFM2p5cVpCbEJQ?=
 =?utf-8?B?NkZRS3VYUmdoYWZNQjF2K0ZXdmJQcWRBUWl5MlNDeVRVMEpVQ0xNTUlwWE5E?=
 =?utf-8?B?THRVZit0d0ZkTHA5ZDRHLzMwd0w0d1Z5V3NXc3d6eVhuR3BKclpzMGorZ2wz?=
 =?utf-8?B?RCtRSFVibDVBbDZlemVVb1JGR0swNFd6MDJwWWtzK2NXMnAxNVRsREIyaXJs?=
 =?utf-8?B?QllyMWo0d3NQY05veVQ4Z1VKZmV2aEM0OEErVm9tNDB5clVXL0Z3c0IrQ0VS?=
 =?utf-8?B?WXJ6NnUyMzBKM0NaUXBZbGhBcStLUnVoMVlxd0RsaFpEell3RDJUaFZ2SjRx?=
 =?utf-8?B?K1JzY1AvUzZxUVBRTkhoZ3FYSE82REZNR0FQRGV2MEVNODUzN01JeVJ1NEhP?=
 =?utf-8?B?QUxFZktwSGJMdzNqRU04cWh4OWJveVRqeXhGNGJkWUtCaW5FclNJOENDa1Vn?=
 =?utf-8?B?aUtyZGhOYUhvQlNwUUtjMU9tTkY3SzM0OXR0RXFJVzRiZDhTeGRoNnVTQnhu?=
 =?utf-8?B?dlpUbmtqYWJ0Z0krME5sOVhwRUZoNlZ4MUFKTzFjQjB4ZEdWNi9iZ0RhdnVS?=
 =?utf-8?B?aVIwbVlhaDNKL2pxb0gzb3Z4eFp2Y0dxMEc4a3VQWkF1ZzRjVjRBSTBHTFFT?=
 =?utf-8?B?bnZ6SkEySWFwMEVYMEhBcG95QUk2QkRnTFl5dUtCd1ZBQXNEUUpTRHJyVmRH?=
 =?utf-8?B?V0UyamRsaHpNbU93bnNCK2tjenlwZmFxcXJPZXhMQ0pLR3JxVmRiL1NaUjEr?=
 =?utf-8?B?cjVrNVdSSDBsQldSbEhFZjFsZWxXcFhGejhQZUpuWThJMDNGYUhCVEl6d0pH?=
 =?utf-8?B?MzFMcWZWREZtZ0dlMFphcTBPcEJZU0Joci9jQm1LNVkxTUhUTTFSK0tqY0Nq?=
 =?utf-8?B?UDFJUTUrM2NQMWlmanNKaXoyWlpLa2d6cW9vTTVGaUFub3V4aFJhVnB2ZGZY?=
 =?utf-8?B?UEYzL1hSTjduWnNWMDIrRVAxQUlCZ0JaNEgrVHU2SlZyZU9CTW9SVmIyR2Qr?=
 =?utf-8?B?MkJoWUIveGdjeWpTdHMxcG9hNmpwOTRGc2J4QlA3WVdHLzFsRERZQ0hGbUMw?=
 =?utf-8?B?c1dnbWRGMUJ4a3Zicmdua2NPZlJpNVUvcEdyVlZwbExxaTFyUTVvZUNkWFl3?=
 =?utf-8?B?Yklwb1B0R1Z4bEUzWnV5QkNXUElpNXF6aEx6MVJzc0ZpOXg4dmEzbHJhMERN?=
 =?utf-8?B?OUFMSGtjT01PejlBTVZBRnRQNWR2Y2E3WHl6cnJtSXU0VndsTlB4REJ3U2dI?=
 =?utf-8?B?WG9Ua0Q4WDRIQU5zaUdHZ2c5RTFWalRHbmt6bjA3di9QUDZETHY1VnhVU08y?=
 =?utf-8?B?Yy8rSGxTQ1hwbVJ0dTVoWERnb09EYi9iV2MwdHV6bElsVHpNRkc4aytKYlh4?=
 =?utf-8?B?WWNTSys3Z0hOeUpWZVJTa0lmMG8zRFAzT3RMcFNZZHdJT28xNi91aHpNY1Fl?=
 =?utf-8?B?YldjVXhCTzU0Zm5uWEVhT2lGL1lTWGR4bk93VEVCSnl1c2F4NFhhanhDdnpp?=
 =?utf-8?B?aytQWjkwbDNLeDZRdjREZmJBV0toUHI2dUVlK0ttbHFQMk5rQWFoUE15c1Jq?=
 =?utf-8?B?UXpEWjBKdU9CZFdIK2I0Z2RucTNqekdnSmVNNGdoTVhwVXdxQ1RPcTlTOGN4?=
 =?utf-8?B?QUM5elh6YnZERTdUbXlTNmRDMTk1eXgrSmtDZ1hHWjdlVGJ6ZXE4NE85M0NH?=
 =?utf-8?B?L0N1M0xwZU12OWRxOTRMWVJHNGwxc0tIdFl2ZGpteWhzQ1lod2ZaTC9rTHV1?=
 =?utf-8?B?cnE1WVdNcFNuK1VEUkxuQXZFVGZyOVAxNVhLVm94RHNrVmd3Q0pCY2Zia1pH?=
 =?utf-8?B?U2dzSmdFK09uSTJZZzl3NmI3djFucEhJazZrNURQSEVKaDRIYTNUaXY4a3lP?=
 =?utf-8?B?aFB1Q045eEM0QUc3V1oza1IrSjRGVTgxdXhzZXNZcUpkZVlUaXhoVlh6YnFX?=
 =?utf-8?B?MGVYcHVSNjV4akxqZ1BvNjkrZVhhMXlBTVdMZzlUWGtwVkFTNk5DL2hGcEhI?=
 =?utf-8?B?eUJ1MDNZang0dmtGeVJXc2FGV0ZxT0xqSU9vM0JaZVJDcEl2L2YzZ2dUNy9F?=
 =?utf-8?B?Ny9KS1Q3V2luL3hNUzYxUGtXUzM3NVpUd0xTN3VDR3RGTHRyMDYvVTQ1eVNL?=
 =?utf-8?B?Vmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <683FFC8FE6CB0D428CF89FA9B3B5797A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c0dd95-567d-4f0d-71e7-08d9e947e254
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2022 08:08:39.7676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pOdIJrQRPp62xW6K+oLc2PldhLTAotVVCzD8f+YD4zTcp/IK1f3arRwzBZVxKipCzh1XznyFSJw22SRhHxa5Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3873
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10249 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202060059
X-Proofpoint-GUID: V6P1lQQa9iPUl6bNxhWhKYn9Do5n0C3Y
X-Proofpoint-ORIG-GUID: V6P1lQQa9iPUl6bNxhWhKYn9Do5n0C3Y
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMi8zLzIwMjIgMTA6MjEgUE0sIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gT24gRnJpLCBKYW4g
MjgsIDIwMjIgYXQgMTozMiBQTSBKYW5lIENodSA8amFuZS5jaHVAb3JhY2xlLmNvbT4gd3JvdGU6
DQo+Pg0KPj4gcG1lbV9yZWNvdmVyeV93cml0ZSgpIGNvbnNpc3RzIG9mIGNsZWFyaW5nIHBvaXNv
biB2aWEgRFNNLA0KPj4gY2xlYXJpbmcgcGFnZSBIV1BvaXNvbiBiaXQsIHJlLXN0YXRlIF9QQUdF
X1BSRVNFTlQgYml0LA0KPj4gY2FjaGVmbHVzaCwgd3JpdGUsIGFuZCBmaW5hbGx5IGNsZWFyaW5n
IGJhZC1ibG9jayByZWNvcmQuDQo+Pg0KPj4gQSBjb21wZXRpbmcgcHJlYWQgdGhyZWFkIGlzIGhl
bGQgb2ZmIGR1cmluZyByZWNvdmVyeSB3cml0ZQ0KPj4gYnkgdGhlIHByZXNlbmNlIG9mIGJhZC1i
bG9jayByZWNvcmQuIEEgY29tcGV0aW5nIHJlY292ZXJ5X3dyaXRlDQo+PiB0aHJlYWQgaXMgc2Vy
aWFsaXplZCBieSBhIGxvY2suDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSmFuZSBDaHUgPGphbmUu
Y2h1QG9yYWNsZS5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9udmRpbW0vcG1lbS5jIHwgODIg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPj4gICBkcml2ZXJz
L252ZGltbS9wbWVtLmggfCAgMSArDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgNzcgaW5zZXJ0aW9u
cygrKSwgNiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udmRpbW0v
cG1lbS5jIGIvZHJpdmVycy9udmRpbW0vcG1lbS5jDQo+PiBpbmRleCA2MzhlNjQ2ODFkYjkuLmYy
ZDZiMzRkNDhkZSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbnZkaW1tL3BtZW0uYw0KPj4gKysr
IGIvZHJpdmVycy9udmRpbW0vcG1lbS5jDQo+PiBAQCAtNjksNiArNjksMTQgQEAgc3RhdGljIHZv
aWQgaHdwb2lzb25fY2xlYXIoc3RydWN0IHBtZW1fZGV2aWNlICpwbWVtLA0KPj4gICAgICAgICAg
fQ0KPj4gICB9DQo+Pg0KPj4gK3N0YXRpYyB2b2lkIHBtZW1fY2xlYXJfYmFkYmxvY2tzKHN0cnVj
dCBwbWVtX2RldmljZSAqcG1lbSwgc2VjdG9yX3Qgc2VjdG9yLA0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBsb25nIGNsZWFyZWRfYmxrcykNCj4+ICt7DQo+PiArICAgICAgIGJh
ZGJsb2Nrc19jbGVhcigmcG1lbS0+YmIsIHNlY3RvciwgY2xlYXJlZF9ibGtzKTsNCj4+ICsgICAg
ICAgaWYgKHBtZW0tPmJiX3N0YXRlKQ0KPj4gKyAgICAgICAgICAgICAgIHN5c2ZzX25vdGlmeV9k
aXJlbnQocG1lbS0+YmJfc3RhdGUpOw0KPj4gK30NCj4+ICsNCj4+ICAgc3RhdGljIGJsa19zdGF0
dXNfdCBwbWVtX2NsZWFyX3BvaXNvbihzdHJ1Y3QgcG1lbV9kZXZpY2UgKnBtZW0sDQo+PiAgICAg
ICAgICAgICAgICAgIHBoeXNfYWRkcl90IG9mZnNldCwgdW5zaWduZWQgaW50IGxlbikNCj4+ICAg
ew0KPj4gQEAgLTg4LDkgKzk2LDcgQEAgc3RhdGljIGJsa19zdGF0dXNfdCBwbWVtX2NsZWFyX3Bv
aXNvbihzdHJ1Y3QgcG1lbV9kZXZpY2UgKnBtZW0sDQo+PiAgICAgICAgICAgICAgICAgIGRldl9k
YmcoZGV2LCAiJSNsbHggY2xlYXIgJWxkIHNlY3RvciVzXG4iLA0KPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKHVuc2lnbmVkIGxvbmcgbG9uZykgc2VjdG9yLCBjbGVhcmVkLA0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2xlYXJlZCA+IDEgPyAicyIgOiAi
Iik7DQo+PiAtICAgICAgICAgICAgICAgYmFkYmxvY2tzX2NsZWFyKCZwbWVtLT5iYiwgc2VjdG9y
LCBjbGVhcmVkKTsNCj4+IC0gICAgICAgICAgICAgICBpZiAocG1lbS0+YmJfc3RhdGUpDQo+PiAt
ICAgICAgICAgICAgICAgICAgICAgICBzeXNmc19ub3RpZnlfZGlyZW50KHBtZW0tPmJiX3N0YXRl
KTsNCj4+ICsgICAgICAgICAgICAgICBwbWVtX2NsZWFyX2JhZGJsb2NrcyhwbWVtLCBzZWN0b3Is
IGNsZWFyZWQpOw0KPj4gICAgICAgICAgfQ0KPj4NCj4+ICAgICAgICAgIGFyY2hfaW52YWxpZGF0
ZV9wbWVtKHBtZW0tPnZpcnRfYWRkciArIG9mZnNldCwgbGVuKTsNCj4+IEBAIC0yNTcsMTAgKzI2
MywxNSBAQCBzdGF0aWMgaW50IHBtZW1fcndfcGFnZShzdHJ1Y3QgYmxvY2tfZGV2aWNlICpiZGV2
LCBzZWN0b3JfdCBzZWN0b3IsDQo+PiAgIF9fd2VhayBsb25nIF9fcG1lbV9kaXJlY3RfYWNjZXNz
KHN0cnVjdCBwbWVtX2RldmljZSAqcG1lbSwgcGdvZmZfdCBwZ29mZiwNCj4+ICAgICAgICAgICAg
ICAgICAgbG9uZyBucl9wYWdlcywgdm9pZCAqKmthZGRyLCBwZm5fdCAqcGZuKQ0KPj4gICB7DQo+
PiArICAgICAgIGJvb2wgYmFkX3BtZW07DQo+PiArICAgICAgIGJvb2wgZG9fcmVjb3ZlcnkgPSBm
YWxzZTsNCj4+ICAgICAgICAgIHJlc291cmNlX3NpemVfdCBvZmZzZXQgPSBQRk5fUEhZUyhwZ29m
ZikgKyBwbWVtLT5kYXRhX29mZnNldDsNCj4+DQo+PiAtICAgICAgIGlmICh1bmxpa2VseShpc19i
YWRfcG1lbSgmcG1lbS0+YmIsIFBGTl9QSFlTKHBnb2ZmKSAvIDUxMiwNCj4+IC0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBQRk5fUEhZUyhucl9wYWdlcykpKSkNCj4+ICsg
ICAgICAgYmFkX3BtZW0gPSBpc19iYWRfcG1lbSgmcG1lbS0+YmIsIFBGTl9QSFlTKHBnb2ZmKSAv
IDUxMiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUEZOX1BIWVMobnJfcGFn
ZXMpKTsNCj4+ICsgICAgICAgaWYgKGJhZF9wbWVtICYmIGthZGRyKQ0KPj4gKyAgICAgICAgICAg
ICAgIGRvX3JlY292ZXJ5ID0gZGF4X3JlY292ZXJ5X3N0YXJ0ZWQocG1lbS0+ZGF4X2Rldiwga2Fk
ZHIpOw0KPj4gKyAgICAgICBpZiAoYmFkX3BtZW0gJiYgIWRvX3JlY292ZXJ5KQ0KPj4gICAgICAg
ICAgICAgICAgICByZXR1cm4gLUVJTzsNCj4+DQo+PiAgICAgICAgICBpZiAoa2FkZHIpDQo+PiBA
QCAtMzAxLDEwICszMTIsNjggQEAgc3RhdGljIGxvbmcgcG1lbV9kYXhfZGlyZWN0X2FjY2Vzcyhz
dHJ1Y3QgZGF4X2RldmljZSAqZGF4X2RldiwNCj4+ICAgICAgICAgIHJldHVybiBfX3BtZW1fZGly
ZWN0X2FjY2VzcyhwbWVtLCBwZ29mZiwgbnJfcGFnZXMsIGthZGRyLCBwZm4pOw0KPj4gICB9DQo+
Pg0KPj4gKy8qDQo+PiArICogVGhlIHJlY292ZXJ5IHdyaXRlIHRocmVhZCBzdGFydGVkIG91dCBh
cyBhIG5vcm1hbCBwd3JpdGUgdGhyZWFkIGFuZA0KPj4gKyAqIHdoZW4gdGhlIGZpbGVzeXN0ZW0g
d2FzIHRvbGQgYWJvdXQgcG90ZW50aWFsIG1lZGlhIGVycm9yIGluIHRoZQ0KPj4gKyAqIHJhbmdl
LCBmaWxlc3lzdGVtIHR1cm5zIHRoZSBub3JtYWwgcHdyaXRlIHRvIGEgZGF4X3JlY292ZXJ5X3dy
aXRlLg0KPj4gKyAqDQo+PiArICogVGhlIHJlY292ZXJ5IHdyaXRlIGNvbnNpc3RzIG9mIGNsZWFy
aW5nIHBvaXNvbiB2aWEgRFNNLCBjbGVhcmluZyBwYWdlDQo+PiArICogSFdQb2lzb24gYml0LCBy
ZWVuYWJsZSBwYWdlLXdpZGUgcmVhZC13cml0ZSBwZXJtaXNzaW9uLCBmbHVzaCB0aGUNCj4+ICsg
KiBjYWNoZXMgYW5kIGZpbmFsbHkgd3JpdGUuICBBIGNvbXBldGluZyBwcmVhZCB0aHJlYWQgbmVl
ZHMgdG8gYmUgaGVsZA0KPj4gKyAqIG9mZiBkdXJpbmcgdGhlIHJlY292ZXJ5IHByb2Nlc3Mgc2lu
Y2UgZGF0YSByZWFkIGJhY2sgbWlnaHQgbm90IGJlIHZhbGlkLg0KPj4gKyAqIEFuZCB0aGF0J3Mg
YWNoaWV2ZWQgYnkgcGxhY2luZyB0aGUgYmFkYmxvY2sgcmVjb3JkcyBjbGVhcmluZyBhZnRlcg0K
Pj4gKyAqIHRoZSBjb21wbGV0aW9uIG9mIHRoZSByZWNvdmVyeSB3cml0ZS4NCj4+ICsgKg0KPj4g
KyAqIEFueSBjb21wZXRpbmcgcmVjb3Zlcnkgd3JpdGUgdGhyZWFkIG5lZWRzIHRvIGJlIHNlcmlh
bGl6ZWQsIGFuZCB0aGlzIGlzDQo+PiArICogZG9uZSB2aWEgcG1lbSBkZXZpY2UgbGV2ZWwgbG9j
ayAucmVjb3ZlcnlfbG9jay4NCj4+ICsgKi8NCj4+ICAgc3RhdGljIHNpemVfdCBwbWVtX3JlY292
ZXJ5X3dyaXRlKHN0cnVjdCBkYXhfZGV2aWNlICpkYXhfZGV2LCBwZ29mZl90IHBnb2ZmLA0KPj4g
ICAgICAgICAgICAgICAgICB2b2lkICphZGRyLCBzaXplX3QgYnl0ZXMsIHN0cnVjdCBpb3ZfaXRl
ciAqaSkNCj4+ICAgew0KPj4gLSAgICAgICByZXR1cm4gMDsNCj4+ICsgICAgICAgc2l6ZV90IHJj
LCBsZW4sIG9mZjsNCj4+ICsgICAgICAgcGh5c19hZGRyX3QgcG1lbV9vZmY7DQo+PiArICAgICAg
IHN0cnVjdCBwbWVtX2RldmljZSAqcG1lbSA9IGRheF9nZXRfcHJpdmF0ZShkYXhfZGV2KTsNCj4+
ICsgICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gcG1lbS0+YmIuZGV2Ow0KPj4gKyAgICAgICBz
ZWN0b3JfdCBzZWN0b3I7DQo+PiArICAgICAgIGxvbmcgY2xlYXJlZCwgY2xlYXJlZF9ibGs7DQo+
PiArDQo+PiArICAgICAgIG11dGV4X2xvY2soJnBtZW0tPnJlY292ZXJ5X2xvY2spOw0KPj4gKw0K
Pj4gKyAgICAgICAvKiBJZiBubyBwb2lzb24gZm91bmQgaW4gdGhlIHJhbmdlLCBnbyBhaGVhZCB3
aXRoIHdyaXRlICovDQo+PiArICAgICAgIG9mZiA9ICh1bnNpZ25lZCBsb25nKWFkZHIgJiB+UEFH
RV9NQVNLOw0KPj4gKyAgICAgICBsZW4gPSBQRk5fUEhZUyhQRk5fVVAob2ZmICsgYnl0ZXMpKTsN
Cj4+ICsgICAgICAgaWYgKCFpc19iYWRfcG1lbSgmcG1lbS0+YmIsIFBGTl9QSFlTKHBnb2ZmKSAv
IDUxMiwgbGVuKSkgew0KPj4gKyAgICAgICAgICAgICAgIHJjID0gX2NvcHlfZnJvbV9pdGVyX2Zs
dXNoY2FjaGUoYWRkciwgYnl0ZXMsIGkpOw0KPj4gKyAgICAgICAgICAgICAgIGdvdG8gd3JpdGVf
ZG9uZTsNCj4+ICsgICAgICAgfQ0KPiANCj4gaXNfYmFkX3BtZW0oKSB0YWtlcyBhIHNlcWxvY2sg
c28gaXQgc2hvdWxkIGJlIHNhZmUgdG8gbW92ZSB0aGUNCj4gcmVjb3ZlcnlfbG9jayBiZWxvdyB0
aGlzIHBvaW50Lg0KDQpPa2F5LCB0aGFua3MhDQoNCj4gDQo+PiArDQo+PiArICAgICAgIC8qIE5v
dCBwYWdlLWFsaWduZWQgcmFuZ2UgY2Fubm90IGJlIHJlY292ZXJlZCAqLw0KPj4gKyAgICAgICBp
ZiAob2ZmIHx8ICEoUEFHRV9BTElHTkVEKGJ5dGVzKSkpIHsNCj4+ICsgICAgICAgICAgICAgICBk
ZXZfd2FybihkZXYsICJGb3VuZCBwb2lzb24sIGJ1dCBhZGRyKCVwKSBvciBieXRlcyglI2x4KSBu
b3QgcGFnZSBhbGlnbmVkXG4iLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgYWRkciwgYnl0
ZXMpOw0KPiANCj4gZnMvZGF4LmMgd2lsbCBwcmV2ZW50IHRoaXMgZnJvbSBoYXBwZW5pbmcsIHJp
Z2h0PyBJdCBzZWVtcyBsaWtlIGFuDQo+IHVwcGVyIGxheWVyIGJ1ZyBpZiB3ZSBnZXQgdGhpcyBm
YXIgaW50byB0aGUgcmVjb3ZlcnkgcHJvY2VzcyB3aXRob3V0DQo+IGNoZWNraW5nIGlmIGEgZnVs
bCBwYWdlIGlzIGJlaW5nIG92ZXJ3cml0dGVuLg0KDQpZZXMsIGF0IHRoZSBzdGFydCBvZiBlYWNo
IGRheF9pb21hcF9pdGVyLCB0aGUgYnVmZmVyIGlzIHBhZ2UgYWxpZ25lZC4gDQpIb3dldmVyLCB0
aGUgdW5kZXJseWluZyBkYXhfY29weV9mcm9tX2l0ZXIgaXMgYWxsb3dlZCB0byByZXR1cm4gcGFy
dGlhbCANCnJlc3VsdHMsIGNhdXNpbmcgdGhlIHN1YnNlcXVlbnQgJ3doaWxlJyBsb29wIHdpdGhp
biBkYXhfaW9tYXBfaXRlciB0byANCmNvbnRpbnVlIGF0IG5vdCBwYWdlIGFsaWduZWQgYWRkcmVz
cy4gSSByYW4gaW50byB0aGUgc2l0dWF0aW9uIHdoZW4gSSANCnBsYXllZCBhcm91bmQgZGF4X2Nv
cHlfZnJvbV9pdGVyLCBub3Qgc3VyZSBpbiByZWFsaXR5LCBwYXJ0aWFsIHJlc3VsdCBpcyANCmxl
Z2l0aW1hdGUsIGp1c3QgdGhvdWdodCB0byBpc3N1ZSBhIHdhcm5pbmcgc2hvdWxkIHRoZSBzaXR1
YXRpb24gaGFwcGVuLg0KDQo+IA0KPj4gKyAgICAgICAgICAgICAgIHJjID0gKHNpemVfdCkgLUVJ
TzsNCj4+ICsgICAgICAgICAgICAgICBnb3RvIHdyaXRlX2RvbmU7DQo+PiArICAgICAgIH0NCj4+
ICsNCj4+ICsgICAgICAgcG1lbV9vZmYgPSBQRk5fUEhZUyhwZ29mZikgKyBwbWVtLT5kYXRhX29m
ZnNldDsNCj4+ICsgICAgICAgc2VjdG9yID0gKHBtZW1fb2ZmIC0gcG1lbS0+ZGF0YV9vZmZzZXQp
IC8gNTEyOw0KPj4gKyAgICAgICBjbGVhcmVkID0gbnZkaW1tX2NsZWFyX3BvaXNvbihkZXYsIHBt
ZW0tPnBoeXNfYWRkciArIHBtZW1fb2ZmLCBsZW4pOw0KPj4gKyAgICAgICBjbGVhcmVkX2JsayA9
IGNsZWFyZWQgLyA1MTI7DQo+PiArICAgICAgIGlmIChjbGVhcmVkX2JsayA+IDApIHsNCj4+ICsg
ICAgICAgICAgICAgICBod3BvaXNvbl9jbGVhcihwbWVtLCBwbWVtLT5waHlzX2FkZHIgKyBwbWVt
X29mZiwgY2xlYXJlZCk7DQo+PiArICAgICAgIH0gZWxzZSB7DQo+PiArICAgICAgICAgICAgICAg
ZGV2X3dhcm4oZGV2LCAicG1lbV9yZWNvdmVyeV93cml0ZTogY2xlYXJlZF9ibGs6ICVsZFxuIiwN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGNsZWFyZWRfYmxrKTsNCj4+ICsgICAgICAgICAg
ICAgICByYyA9IChzaXplX3QpIC1FSU87DQo+PiArICAgICAgICAgICAgICAgZ290byB3cml0ZV9k
b25lOw0KPj4gKyAgICAgICB9DQo+PiArICAgICAgIGFyY2hfaW52YWxpZGF0ZV9wbWVtKHBtZW0t
PnZpcnRfYWRkciArIHBtZW1fb2ZmLCBieXRlcyk7DQo+PiArICAgICAgIHJjID0gX2NvcHlfZnJv
bV9pdGVyX2ZsdXNoY2FjaGUoYWRkciwgYnl0ZXMsIGkpOw0KPj4gKyAgICAgICBwbWVtX2NsZWFy
X2JhZGJsb2NrcyhwbWVtLCBzZWN0b3IsIGNsZWFyZWRfYmxrKTsNCj4gDQo+IFRoaXMgZHVwbGlj
YXRlcyBwbWVtX2NsZWFyX3BvaXNvbigpIGNhbiBtb3JlIGNvZGUgYmUgc2hhcmVkIGJldHdlZW4N
Cj4gdGhlIDIgZnVuY3Rpb25zPw0KDQpJJ2xsIGxvb2sgaW50byByZWZhY3RvcmluZyBwbWVtX2Ns
ZWFyX3BvaXNvbigpLg0KPiANCj4gDQo+PiArDQo+PiArd3JpdGVfZG9uZToNCj4+ICsgICAgICAg
bXV0ZXhfdW5sb2NrKCZwbWVtLT5yZWNvdmVyeV9sb2NrKTsNCj4+ICsgICAgICAgcmV0dXJuIHJj
Ow0KPj4gICB9DQo+Pg0KPj4gICBzdGF0aWMgY29uc3Qgc3RydWN0IGRheF9vcGVyYXRpb25zIHBt
ZW1fZGF4X29wcyA9IHsNCj4+IEBAIC00OTUsNiArNTY0LDcgQEAgc3RhdGljIGludCBwbWVtX2F0
dGFjaF9kaXNrKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4+ICAgICAgICAgICAgICAgICAgZ290byBv
dXRfY2xlYW51cF9kYXg7DQo+PiAgICAgICAgICBkYXhfd3JpdGVfY2FjaGUoZGF4X2RldiwgbnZk
aW1tX2hhc19jYWNoZShuZF9yZWdpb24pKTsNCj4+ICAgICAgICAgIHNldF9kYXhfcmVjb3Zlcnko
ZGF4X2Rldik7DQo+PiArICAgICAgIG11dGV4X2luaXQoJnBtZW0tPnJlY292ZXJ5X2xvY2spOw0K
Pj4gICAgICAgICAgcG1lbS0+ZGF4X2RldiA9IGRheF9kZXY7DQo+Pg0KPj4gICAgICAgICAgcmMg
PSBkZXZpY2VfYWRkX2Rpc2soZGV2LCBkaXNrLCBwbWVtX2F0dHJpYnV0ZV9ncm91cHMpOw0KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZkaW1tL3BtZW0uaCBiL2RyaXZlcnMvbnZkaW1tL3BtZW0u
aA0KPj4gaW5kZXggNTljZmUxM2VhOGE4Li45NzFiZmY3NTUyZDYgMTAwNjQ0DQo+PiAtLS0gYS9k
cml2ZXJzL252ZGltbS9wbWVtLmgNCj4+ICsrKyBiL2RyaXZlcnMvbnZkaW1tL3BtZW0uaA0KPj4g
QEAgLTI0LDYgKzI0LDcgQEAgc3RydWN0IHBtZW1fZGV2aWNlIHsNCj4+ICAgICAgICAgIHN0cnVj
dCBkYXhfZGV2aWNlICAgICAgICpkYXhfZGV2Ow0KPj4gICAgICAgICAgc3RydWN0IGdlbmRpc2sg
ICAgICAgICAgKmRpc2s7DQo+PiAgICAgICAgICBzdHJ1Y3QgZGV2X3BhZ2VtYXAgICAgICBwZ21h
cDsNCj4+ICsgICAgICAgc3RydWN0IG11dGV4ICAgICAgICAgICAgcmVjb3ZlcnlfbG9jazsNCj4+
ICAgfTsNCj4+DQo+PiAgIGxvbmcgX19wbWVtX2RpcmVjdF9hY2Nlc3Moc3RydWN0IHBtZW1fZGV2
aWNlICpwbWVtLCBwZ29mZl90IHBnb2ZmLA0KPj4gLS0NCj4+IDIuMTguNA0KPj4NCg0KdGhhbmtz
IQ0KLWphbmUNCg==
