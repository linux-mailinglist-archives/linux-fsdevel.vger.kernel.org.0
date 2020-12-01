Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748FF2C9EF8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 11:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388050AbgLAKRi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 05:17:38 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:11734 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729600AbgLAKRi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606817857; x=1638353857;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=7tL4MQERU3/PKG4Dxf62HOnSYhmXT1lSsf4bIW2IMPs=;
  b=nhTEP6XRhQIbiXmiwge0Zww/ZrXlqPPUmYsiN+s14gJBZLDPttMubBF5
   XThsiCLSUx6E+gYTGiA2zBxA1TBxlrJeFxq1p4vJdrzcf/KyZtwgMkObG
   Y3X7K9CjrZYM6h99BMO7nCxPlvvPAuO67dsnin2rPASGEaMb0NsuY9WhR
   JLweqXlO5qfnNXhlpfdrnhd7yE61BaOP3E0ECHaFnPpuNjnsINQTb+nlq
   cE87pVqPfKKW+D7FmPSuQqDXiWfk5jC0f8Y/DYH6bg67xqSIRsiw3iBPI
   neVa8wFZ28c0vKM0lA6PLaNWQ3CPhmJYCvFjkgly+MOamqVUynU2s41h5
   w==;
IronPort-SDR: e/ZSzR/oh8TsbiZau6pZAJsTI8iLm6ai9I1YzCdftWhKyCeFSdMDSF5RU+n6KIbIi9p3ijOuIu
 CvseJRelQOjKEZiskC/2diSjxruvVfsUCLKMYFELU3MTZJaEhY9LpxBJI+lKTi0r/ZeWTkfZd+
 YnGyo7tzhWgMTdnqi5xQMkZMQ6WnJETUqcmSs0WNoGSBet29J4vw3Dog9Sod7Aj2oFTYvQ2AZX
 k7BgjQiHgH6GX23MENI8BFcJUkR81fbjsxy4muTTsFJ3+lyOSXNu2ypYLVD7jOjIva016/ORgZ
 hc4=
X-IronPort-AV: E=Sophos;i="5.78,384,1599494400"; 
   d="scan'208";a="264034769"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 18:16:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfSvJ/LBNJo10CAtX0Fz2O4ojwWzWTcNA1NljsJe/JdmSPmKUABOell4kBSBq73ZUl4FzW2B2+IlQwiFbd+gsS8NdHIfmTUuXuGS7eq8xsr2/xbauIsfhgnDyeXtNV7eVP+M8SuLAV1+8/7kDIS4bgivFU3QOWxNbzi/Ova4VGgR2Ai/WSIdU3hXPBjvibGk1ICezFHcq9KmkWECgd0tvlnqV3aVO001lKokA2DQGixTdzOZrddZM4Vv2mizCXyhZEzz4rDrrLAA0+QvRuZyKQezh0U19PrcAL7XQE5TsIu649plOhjcr7WvgBUPvOli9i471hTsuFL5A1MRnuAyqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tL4MQERU3/PKG4Dxf62HOnSYhmXT1lSsf4bIW2IMPs=;
 b=aMBhuiBbnJ08hYQG6q1vWXxn3SjcGrt+paM7sBPy8SZTQffCwcdFLW9QBWZ8ZB+0L6erEeChgx17SMWTk3XLpcHUGwU3Iy2DYIIGG4IjQCG06DE6K5MMBq0olrEN6wh1NMHJBDFWbiFt3luHoMVsjlARdgqW0GCWaO5XB1gBs1ToA608ryg1tkCpdfIxCWHVT/KbF+LtKfl0eHxTR0N3lq1lmDSjK4sv4hM52mtZFVOft8/8EH9ET7odc4mtFECud+K5hXYVWHG8gfqsspn2HYPHAn5nbPzahEa+H01irnEzTmGfqMLShjvSjZbfVNaPEpTuRZcGrAZ6RRWPy+cPfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tL4MQERU3/PKG4Dxf62HOnSYhmXT1lSsf4bIW2IMPs=;
 b=pw8XzTyJvTArkfqlzwt5grYZUTE5euoktfDhGmQsvslIFJhKu2YchG4dMXncfr3hyvJHEnR7IV74ZO5vR6UXi3jV4wAUEhi7oIV9LKMl5W9MFkUHqHxnfTncOchkL/Fw3UDYkESSY2qUiQSvWTpTCtLL6CX+1uh+gQpH92ah2EA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3597.namprd04.prod.outlook.com
 (2603:10b6:803:45::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Tue, 1 Dec
 2020 10:16:30 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.030; Tue, 1 Dec 2020
 10:16:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH v10 02/41] iomap: support REQ_OP_ZONE_APPEND
Thread-Topic: [PATCH v10 02/41] iomap: support REQ_OP_ZONE_APPEND
Thread-Index: AQHWt1Sb3HZRbzGDlk6Pnuh0g860vw==
Date:   Tue, 1 Dec 2020 10:16:30 +0000
Message-ID: <SN4PR0401MB3598CA7F550944DDF322AC599BF40@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <72734501cc1d9e08117c215ed60f7b38e3665f14.1605007036.git.naohiro.aota@wdc.com>
 <20201130181104.GA143005@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:155d:1001:b8ae:bd87:d6c6:21f6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 71c832b6-4fa5-409c-3fc8-08d895e22c27
x-ms-traffictypediagnostic: SN4PR0401MB3597:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3597A76FBA3464A1A30413F09BF40@SN4PR0401MB3597.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:608;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DIedwrJaI/ghVsTs/spIzSJJABNusT4KtCsRFCinOOtEFJFlf0SzkvP8KVDhyFa77nocrLyFwVqGlHczUnqRVKHNnO02RY2LtMwHXnavAE2P6iltaNcXdro8BtYA6BAImlid12FWmckOd1xJCISJ3rwo/lE0EGmnqrZl56/t6r84Kw08/I7epGePmXZ9t7CXePrRGvkEXveWzqkE2RB2oyTREEmU3ZAxKMKJb9STAMi7IaaPnXxztDwacMVaIm4pKO41035XjmiwhWP41GHNgIGgWnUBeTY/xF3qDBLfsUYQlMgDd9cbmF99ifmp8H9E0ihcvI+Dvymu34hFx6RmDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(66556008)(6636002)(316002)(110136005)(54906003)(4744005)(2906002)(8676002)(64756008)(8936002)(66446008)(52536014)(91956017)(76116006)(86362001)(66946007)(7696005)(66476007)(71200400001)(33656002)(83380400001)(5660300002)(9686003)(186003)(53546011)(478600001)(6506007)(4326008)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?AuTSuW/8OzOzgH3xL0WZx+B7C4GL61jxe4zoYCoZQqdAWmJ9FJ1pMD00+K2l?=
 =?us-ascii?Q?zVqiqtsuJ+iQoTVIhHRosSUOwYESl3jXCIfo9ce0WdhKt1UrJsSMnBQX4ZOY?=
 =?us-ascii?Q?b04fQUFFxQgbHNgrvTjNpLrOmG7GWRC4jCiy1y4rJAocMpbEGG9EXfBwrhPC?=
 =?us-ascii?Q?l28oYzOUrg9/QmJW0LgBw+aHh20LO+zT5jpbZXo1UFpTWFKoAUVfqMA3k9Sj?=
 =?us-ascii?Q?/5WzwyGtGdNSuF7WOqiFNadjakf+dCRUdoEcYxizHWyedG5ps7j9VdFtb+6i?=
 =?us-ascii?Q?+Gs0sI8MzoPCDoBVqSf+MFVn2k6fOPOR0MdgWJTupQTy6LoOtZbEKmfHo+N5?=
 =?us-ascii?Q?T6tPpltBVvAwijETCXOCo3yk+UsPnjNi6LDboVW4hdIj0fWJUSEWu+qOGrd2?=
 =?us-ascii?Q?+fSoy9ju+2DNvV2ywJEomYtjaeDQKXyPhc+9g2xcL3ubd8U+W19tdb9icDep?=
 =?us-ascii?Q?mUJTjtLqHUHzkjVEjEibYOQg6kqLfSfciq9xxbIXNZWQc6viAaQygZmrbGd0?=
 =?us-ascii?Q?k8Pu7QCb2/IvjFW9k3h+2HeGxQC2fvDHYfLl8ntZ0kAYCxFComyi0kRJGf5n?=
 =?us-ascii?Q?+q069NKhc6sRKLuFD6I5lulbGW7DwAsMxwwOWplRi7782pYI3j8QF/XdyDZz?=
 =?us-ascii?Q?SMLeWrAt6ooBBkzyjko9eZmwxYCA3+a9h0SQP4v2YR0iaYwbhQQ7gOnsjuLr?=
 =?us-ascii?Q?8JyGzcANS6nyRCp2J52GkijmCHyTebHMrNnC6x1qcmVSeqtAOz/Ayk6XFBfA?=
 =?us-ascii?Q?mYQIXd+LDOqZvuBk98D+NAbNUTNm/CghXR7JrtjiKIZ2N+IHpr/J1iA4oXnw?=
 =?us-ascii?Q?YzGQC99C0BG6+9iBh3da+YYns0Dr6o+udMLRGma4jzSolHPEoE1JlOTdbB03?=
 =?us-ascii?Q?eEr44Z/3hDXe5WJha7KmPJl/WWihbPvGXd46Ux4TTkblp4Sfkp7dm1BcFpVO?=
 =?us-ascii?Q?vLJSS6CxQLlq7mpRsoKY2EoUcW6KcPCGoH90HKLObiU2ZTNrvg1qbvKUryh2?=
 =?us-ascii?Q?3raBTtVs0j3B24Y9lr/y0EHZVEatvHsAkR7mEVEB7Qdfy4FuscPoZgFoFGIe?=
 =?us-ascii?Q?2gaSZrPM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c832b6-4fa5-409c-3fc8-08d895e22c27
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 10:16:30.7503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WVSrlc2Mes2JhMlH+jffAL6PrMywr/JK4PnphcFBVZRTcVyxbGR1Ti9c7XaQfgVWn0+s8uKgIjMrLnfFHfXuXjJzdEXAu+5SQAv5mhmqh1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3597
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 30/11/2020 19:16, Darrick J. Wong wrote:=0A=
> On Tue, Nov 10, 2020 at 08:26:05PM +0900, Naohiro Aota wrote:=0A=
>> A ZONE_APPEND bio must follow hardware restrictions (e.g. not exceeding=
=0A=
>> max_zone_append_sectors) not to be split. bio_iov_iter_get_pages builds=
=0A=
>> such restricted bio using __bio_iov_append_get_pages if bio_op(bio) =3D=
=3D=0A=
>> REQ_OP_ZONE_APPEND.=0A=
>>=0A=
>> To utilize it, we need to set the bio_op before calling=0A=
>> bio_iov_iter_get_pages(). This commit introduces IOMAP_F_ZONE_APPEND, so=
=0A=
>> that iomap user can set the flag to indicate they want REQ_OP_ZONE_APPEN=
D=0A=
>> and restricted bio.=0A=
>>=0A=
>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
> =0A=
> Christoph's answers seem reasonable to me, so=0A=
> =0A=
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>=0A=
> =0A=
> Er... do you want me to take this one via the iomap tree?=0A=
=0A=
Ahm probably yes, but we have an update addressing Christoph's coming=0A=
with the next version series.=0A=
