Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB9729D490
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Oct 2020 22:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgJ1VxR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 17:53:17 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:44037 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbgJ1VxP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603921995; x=1635457995;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=LrbKzy1TPxr6giRd+6cIwVKKDlxfA9qR/+qkG46H2Hs=;
  b=j47iaimeKeE1aTU4WLMFDMGbgRotZbtV9DBaHwlEELVuL6D9TN7mg0Hu
   H31C63fOZQqJehSk3eTEDurllgPbjVw0Irf2OIzSTQGRM9C9jLNqQ83Ll
   wz8pSCPZ/wxVcsXyB7+V7IOLCqZS7karOPJ3YDeFKPvdTCs9gHC7Qizrb
   bpEfu891QwmgUR/E+i5Pw7YfPI/8njbrde1wXngNPFDfzhHpLqIxLpPEw
   W+MedckHSSZxFrMIv3EbzUULNq9vijJdFQcealyHUL5R+hA15yhmzX4f1
   FunkiRdwt5n4RmMBLSj+NCXhr4UMTmSOj4KmIjcgMGz5ADu0AmpUdtvwh
   w==;
IronPort-SDR: 8E47uVRX5uqr6YZvPr0byVWDxozazBq3C+iY/0pWyrUll7auqzMdoRl4KcabBHwTBI25fkhBu8
 EDA+nvMPUzoV3+4qQqkh4IsEq2aNVOstS9+h0e6oM0JEPGSI+cw1yXP1jwyJoZiN1+eyaXd+m8
 8cJk0fOdSgwQdKJEC290MfxPrPraaZS13U18dZ3arTtyNaqtmlmlTI94CfOUco/CkEv51RCU6A
 71Rjhbc/1H8mCeSQGMmc7UyW9lLCr+nP7Kvh9pYnK4hDR9GTdotpskURWaGtLMhEc/6hfHZ9Aq
 AdY=
X-IronPort-AV: E=Sophos;i="5.77,426,1596470400"; 
   d="scan'208";a="151200130"
Received: from mail-bl2nam02lp2055.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.55])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2020 22:49:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kkb7RCAr0ndF4Gse+8dojQbzYOB16z/PDw/FrhNWxDs9s9RUWkybzgTayDN+1mU1LhfwIrM9Or53DovJ2n3hrmQym1RrEq5hTab/uMkHl6ch+XMmqFwSx1aloddurjSKEGql55+BAYLZI8NY+AeTrlc/uHlplwoAM87oJ7EtuL42IFRZ3v35NS4TaCjtrMXhDFxhHxf2xz3wdUupmbf0YsQV5MWijQveAPU6LdCwC/SM/h0FfwUKh4sZe91Wn03JhyyTfFnCsoanHROg4lASLIw/2Xmy6VUR5D0Ralk66HMFtOl7UlaK7UW6T0gknRl66kYSvQj34GdKIfXk0JRsHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5qfTnclRciogyH+5ZAKj5dEaqdM3sAdZvpxfGRXDW4=;
 b=dQ4Xk4JhDAyaTTfGfauelLK9jcD6M5PjKRytEa4P4s6xBYyY7jUNfaad80q9+MtMNoO1Yurd//+cKRnm6Z1VqxIZGnlFbnf/7Kwy0K65L57qMPaxU8+DgY3hifGBwOK41GFSakBjYY8RDXXNrmi8WBsCxuP6fKDD8Quq42qvZIad5Qe3NgewRECswk8Wc3LPoUKAKR2Qb4536pvipSaj1O5sEpWRjD8pE4o/6mGEDzzFHjxIG67KCX5F1wUUtyogHLz9eYu+f5FHgInG55J83CvP1hO1CfSUKMofNE2dgxCM4q+3uczP8a2Xvs5+Pm8m9IIrdzSJGfWujbqrLM8aKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5qfTnclRciogyH+5ZAKj5dEaqdM3sAdZvpxfGRXDW4=;
 b=Lxe5yIM2/Di+Utufb4RD1kVAEQJjzy7JkG6C2yD46OLPmz0BjICDddh6usniQdhDCN9Fz+0RWoTxBvYmN+obRbkNb47uMJ+WnEd60mGEzTv1o/0tkBnnMKNZYnuIB60y71lT/7V6H/aABvGMkOss02cnTIQg3mTNbKJo7Xx9FcA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3518.namprd04.prod.outlook.com
 (2603:10b6:803:4f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Wed, 28 Oct
 2020 14:49:44 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 14:49:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v8 04/41] btrfs: Check and enable ZONED mode
Thread-Topic: [PATCH v8 04/41] btrfs: Check and enable ZONED mode
Thread-Index: AQHWmuaeTAhwDj80AU+iI1ugem6P5A==
Date:   Wed, 28 Oct 2020 14:49:44 +0000
Message-ID: <SN4PR0401MB3598CD69FBC129AFC604662C9B170@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1601572459.git.naohiro.aota@wdc.com>
 <c6d9f70f9b9264497aa630d6c95d8d387b012d57.1601574234.git.naohiro.aota@wdc.com>
 <20201013155633.GF6756@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:14ff:e901:6cb8:d20c:c0d4:b38a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ca08a33-7109-4650-d240-08d87b50b59f
x-ms-traffictypediagnostic: SN4PR0401MB3518:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3518255B00F686EF8AA013259B170@SN4PR0401MB3518.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UqDMmXngE3TXGl5YbAtcWGldNu/TPhTKd/zQ83wxsB+BtY2ThzKORrfBAm2Jw9LyMU1IbWK0lkWte6QkcQUM9FCMYQIFtmsqBqaFJS/rd/gLDyyubiDgK9/Xrnz3/pY9SBqIMcMWsmmFYufkxFCxk3DCjvE1hjRjBHH2ruu86v7qoTb1qVqU7gLVyUDqmZLxxwS0od0+F+pp3E8OdnevrvoLj5l2yN6mwySEqM/nQRK/EmyxxHOX0E+9XhbCRBuL2koSKC9U6jfkVEKv2tdEqEcUpreBI9A8M2IKbsYtUrqRmIIE95Q9AunZtmYIYAkeq0vvdH26xIO3oNKk7mFP/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(33656002)(186003)(66446008)(64756008)(5660300002)(2906002)(4326008)(6506007)(53546011)(4744005)(478600001)(66476007)(76116006)(71200400001)(66556008)(54906003)(9686003)(7696005)(8676002)(91956017)(86362001)(8936002)(66946007)(110136005)(316002)(52536014)(83380400001)(55016002)(6636002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ToY/Ql2b3tV1GkrFT9sjLE9gUu0e6blzUf52bGfpiXovrUsQ3FCqvS2K82wFs+GcUjXbYMVZEuF7saE0vM4/1ezQVppgq7yk2uIt7v+khJiMSUJIQreeAIOxg/HK3o7qaV5fsi1PgvjbEh3WUwduSC5SPgpdeN2f3C9aOLuou7jJJ+7RIdBiojI4vNcxmAqA+4gYYc4UEKCcyzXPyfpobrB5hEGiJ97dSGMwlBVgJRI34Fodjo19BaGh/hpjaQgKie2cq8YMkCQIXT7DCtCJUuaGgyzXVp10/uP1EEw5lE4O70x2F/V1dg3Zg0+8PU9B7KGCEZD88kcT6QXLJJy2VoW90Bf8oXmcYfdALy8+cduRzM1t/MwpMKmtjc3Lb0T/wnQ0x5YQTTYcUNG19jK/RrUPxe57FOuN7ljtNDNX9+Ifhn4wtJTJC6E7o1C3p14Jda/kwwS657MaetgNep8jN+PNlfx6IdOm0ZSdbYEI19UCFTiidiR2MP/J7FZBSCOTCNzlE9Xa+OoduITulpTfATuks3CMnq+wZcqpzkQ4JftIXzQWN/vY9BDQN7TTjQ6+TmFHzAPb9ruNkw1Dqyp3FoLmRBbW/G69olT4locPsLyLmjrgiUahmyIM4YN8/zqAxDk45CFZMeK5KRfvlikThCTkC+3dkR5RxG1mA3urEU6e4YNT4cpBmtyZfO3JbdLMZfQrlYpRc0DSWPfRp0YbYg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca08a33-7109-4650-d240-08d87b50b59f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 14:49:44.6606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NcppI16ub39Q/3zFlBi3rKCoAJ5wU7sdgedKBz3CZmmwOrvSfEIEhq904Ujj6SLZbMcnrg7OvRZZsjd1HOfVfXZQmeek0YbGf2k9Gbgr91E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3518
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13/10/2020 17:58, David Sterba wrote:=0A=
> On Fri, Oct 02, 2020 at 03:36:11AM +0900, Naohiro Aota wrote:=0A=
>> --- a/fs/btrfs/ctree.h=0A=
>> +++ b/fs/btrfs/ctree.h=0A=
>> @@ -588,6 +588,9 @@ struct btrfs_fs_info {=0A=
>>  	struct btrfs_root *free_space_root;=0A=
>>  	struct btrfs_root *data_reloc_root;=0A=
>>  =0A=
>> +	/* Zone size when in ZONED mode */=0A=
>> +	u64 zone_size;=0A=
> =0A=
> I think this could be reused to avoid the lengthy=0A=
> =0A=
> 	if (btrfs_fs_incompat(fs_info, ZONED))=0A=
> =0A=
> to do=0A=
> =0A=
> 	if (fs_info->zoned)=0A=
> =0A=
> In order to keep the semantics of both an anonymouns union should work:=
=0A=
> =0A=
> 	union {=0A=
> 		u64 zone_size;=0A=
> 		u64 zone;=0A=
> 	};=0A=
> =0A=
> and the existing usage of zone_size can be kept intact.=0A=
> =0A=
=0A=
I've opted for a bool zoned in fs_info and a btrfs_is_zoned(fs_info) inline=
 function,=0A=
which we can get rid of again if you just want fs_info->zoned.=0A=
=0A=
