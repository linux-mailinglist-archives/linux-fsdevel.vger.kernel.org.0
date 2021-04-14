Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280AC35FD91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Apr 2021 00:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhDNWFl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 18:05:41 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:6602 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhDNWFk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 18:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618437919; x=1649973919;
  h=from:to:cc:subject:date:message-id:references:
   mime-version;
  bh=6vmFa1raFlgPDs4LJkI/4CDxlRJzD5XOxyiXxh0VakA=;
  b=F9dbV1Kuv0+5XEc4z5YRtTJQHEmoM8VeM/fh9V4Yr+6ibgP5DoeXF3nb
   v0HTymkcXfZw+42NACw4tFUdVqDFTriOIRwU0kjO6wc0w98cOPWZwV9ib
   arWHSQ6BczE2/JqSE0SBTkqa22wleGIXpCT9PMPWtbELsuk0HT25v+wEd
   DSm9/xuJocVVPE5DiOpBR5Foeku9lwGggHNy86xrB7GyXCm9f6Ol5I/OL
   QsErIlCIW0FcOkfbfLnu0BJWQz/U8pFOcvyg67iBz+WQLYq42du5OVIzT
   vbD5OsHjra25eDi9WKvXoANPG5QnZTyhmjBnDJEQjsq/YC9GcQSpl2A/U
   g==;
IronPort-SDR: 3eGKB2js+j0h1+mnkHk+5OCGpvr7dTWKuuZT6WUfo+BAXTFFsB51kJWG46qTdhUjzI8iBD1U1w
 072g2bOseRdtPPBV8IGOnV9BxKXSvb+XjmWs/RvK9K/p7cKx3u0miwY2ukYpuLkqnewyjUf9B6
 3rZb99ppnLah1yyC32uojLZB+nafQ1o7PvrGCTFOHZ1+AZhLdYKeUYxTS1k297R8FYzryi8do9
 pMNSCZv890WLOct4g4NK+S9WlncD/s4Tjbkl9EC00Cccr1MYesi4DeNsOwaWtqYI/wu2pfcktt
 aqM=
X-IronPort-AV: E=Sophos;i="5.82,223,1613404800"; 
   d="sh'?scan'208";a="164332116"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2021 06:05:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgR+aT8EfRiL7RPqH59CBmPR0gdtJ2HIVl/wGO5A+pJ6ezRwPYX2jers4SFXBWQv/lzaoHAgJoo/G8+CyqxjF5gkvma2M3n7lpjpvVr3fu6yEI1j8eGpFsAC7VHUs5BawveS5dd2ZtMFI2cHCvIw+JarLbTq/ptySs+D3FwWDgQeM/JQaOzI/QQCPbtoWi27fORuoJ0pDk1AYczAhIDA3U233A8h5id5XZgE21oatEFlQQWjUAmzCCbexSWAdXnoQGzOZdlhB0PDYLU2Js6b4IWskjo8jN+GLJf/stB9pxfqayXhlJ17okkoyvMqnLXAtvZUDGz1k0jqvTJa2uKMYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYqRBkVa9CKmmRRv1VqYGG9m5dlxDFij33XZCEzFNvE=;
 b=eu9CvRWS+ThbDyPnJcXS4TG0/ejcDykHyTgJZLZ/EwbLdephhWwNj7dxhQjJtlDXovLrpEdBkRpx5Qv56EJH0q4AyEgPjqEf+WXgbdw52uDf+L4xJLY+G8AA6g8tvr/k8ZGo2N6CINMo66BdxCTbtCgJgWWdvz1LFgsEnQLPxtCM/NDX6a1LQjSfSA5UxQIDZr6y5sbDXGNk3fs4tUswVb4rSBORpAOXLU/FC3RefL6rFtJYeZwW+lMEISQOEWX4SbzGfbszSdnRJXow9Ebjs6GdO9XRl7SJFX9QVTL4huNJ5zhXMjEzGDyaGttZJ3r/KM4NhEi2h1KxaPRrxyQQDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYqRBkVa9CKmmRRv1VqYGG9m5dlxDFij33XZCEzFNvE=;
 b=VEEoBsMHui6qC9arXHX+BNKfQOMeqiVG8IDeDGLmyKujEszirecEydbCjSmTwqt3YITs+TwpJHl0GqRr2FOk7b3K4Jg/JbKdpPQnH9B/pIvN9DSvNeEGt7Ds/JbyJo9la9oECPLYnFRSg33aAWEI2dbxNZlHpCgjlHDzGn8UPqA=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4980.namprd04.prod.outlook.com (2603:10b6:208:53::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Wed, 14 Apr
 2021 22:04:55 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4042.016; Wed, 14 Apr 2021
 22:04:55 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Karel Zak <kzak@redhat.com>, Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v2 0/3] implement zone-aware probing/wiping for zoned
 btrfs
Thread-Topic: [PATCH v2 0/3] implement zone-aware probing/wiping for zoned
 btrfs
Thread-Index: AQHXMM423/1BsPwiiUSoh+PlDbjMoA==
Date:   Wed, 14 Apr 2021 22:04:55 +0000
Message-ID: <BL0PR04MB6514EAAA034ADFFAFBF61CFCE74E9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210414013339.2936229-1-naohiro.aota@wdc.com>
 <20210414140946.j57uo7kvlfkpwsz3@ws.net.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f11e:f01a:1ba9:a5b4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78a0f901-6665-4172-2bdd-08d8ff91563c
x-ms-traffictypediagnostic: BL0PR04MB4980:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4980BDD9F36E0F39374B212EE74E9@BL0PR04MB4980.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NZEAUGL3q5EiyzxoxxDG9kfqGA1nA5Oa4+7I06yl7yTVsrsp0WhotjKXHPxzasLeefqGBjIX+7pOeetSTo+Cm0AewLs7nqcV7Ybhr8KVc64JRiEN5PGzDV1X5rrcgKCBavdM2azF+o/Q617e2CdYJop0amDS2SbsYERvSBeh5/p6JWvostmBgtj6xwVzqz2MY5B0Ym0CWuw1Y6ZKhQ5fy+gC3Iac4iBA6zCSPb2BpRWgvuSq0TpnsLqN+3hP2qUIJ0m6upuXKmc1hTkIFtFW3XB5PHqVYaakOJZOq7eu5HVCxvtIrBBiMGN4AvZqREyMZW3ZgvKS//UvQG/rKDlwTheuSmqN/ULkKKYpKlkLLYMKn7zik8WM1D2dKl9Z/Awnf8+0dJmSZr1dzvBAmiBRskn49nNbBsmDjEUiX3jKiTD1ociVewvQgVsRiL9MC7h5gBuoA0UjMRicTi55irLz4eauJbPaETRUnk2Ten3V/tJYmbyIz51L6kHk8XcD2wSd+T/oiIzfSYB/7ap6J0jnHzssLLTArEv8+A6hu4MmDGtP4ba4ijX7mXZT8RSpLDKRcaLTgzdqpvHJkUgEw0N+avmaF26oL0nQufO3eLg+TB3PIg3ZIOIU8wAq4Tjd58Zn0vMuS5YRrJ1QAhHiV950Jg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(186003)(66556008)(8936002)(55016002)(66446008)(478600001)(54906003)(2906002)(66476007)(38100700002)(66946007)(83380400001)(64756008)(4326008)(8676002)(122000001)(9686003)(71200400001)(33656002)(110136005)(91956017)(66616009)(5660300002)(86362001)(76116006)(316002)(99936003)(52536014)(6506007)(6636002)(7696005)(53546011)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?24vvk0T0+PiafM8bLd/1pk4bEhz+8LSmPtMWM4dt2DPRcDGobWH+q0Rjq8F0?=
 =?us-ascii?Q?WppjqGOa+VlMU5ApWj3C8HizHBoY9yHdq6Tj/A4FLM0WhkiPgf2yPdbK2zo1?=
 =?us-ascii?Q?8YSXGf19KtEi4dVmu510ThCseZmosBuDs0xueb6+y/vmKDnys39WAxOT3yWv?=
 =?us-ascii?Q?hb1G4ijAIxHRXJ6NYjWFr0W14wGPWnz8LGlsuw1bwsnYceRvYOGXMXUG0x/n?=
 =?us-ascii?Q?XdjY9lqi67GiU0NpatjWK8CA2j722MQVJbas/AfuDtAi3ucOZhpwQVs9hMHu?=
 =?us-ascii?Q?JBtqHU9ENjE3is770uNRVhc7tu+7t+Vd2MjVWnJtPJ/j/ubGc7CdSySUdDZ6?=
 =?us-ascii?Q?mkN/TR1RyP/nGMPa9swzUFkeKCJQJRSKoUAGiFZqdfixYIAiWvK9dOvASbVP?=
 =?us-ascii?Q?E19QEWFsR32hdmy1gqOJ2i7Tj37ij5tLYGiHkkDAF2zyd5b2aXDJg1IbKrgu?=
 =?us-ascii?Q?ArQWLdTBDfnnCS03GrPAC7WoE9Ay+V0p37tvVHsW9TtderkfuPMdyfWcz+UH?=
 =?us-ascii?Q?nJjItCyhH+2A/ggtw/05U0mdTqs5YEe7uC/+qHuNp8fNr1ROhOGuMfq4K/39?=
 =?us-ascii?Q?Lgs0oymJTGlC7NHo4hLkXn55p8vvtZZdLAIAjZI3uAIEYBAzcaECTrXhw8hE?=
 =?us-ascii?Q?vV5pn4Aiekoe+TKDsESqo0uEUMT73gsO4mtu8hS1oDYR0/SsWbp2jjotu8JJ?=
 =?us-ascii?Q?Ik7ZE0y+RLJxNaHryx7vW5nk9SEYk5eX39Ksk3PD/NJUgNmeISt14a89l+gG?=
 =?us-ascii?Q?XlnRp28iBGUZZsr58oxwVbas0qxOgB1RahQsFPVwENkUIGrLG0fxGqw7YZCS?=
 =?us-ascii?Q?r0wDr7wR3kOZYTfy734mp+OSlxwEvZsujOI86N+JUkRkUwlHaL5tDa1KT0/k?=
 =?us-ascii?Q?Zf3472wzIh51MAYVoQLJ8x3peno1RMlo+X1E7kL2DRkyV1cr/Gb1ktnO1LQS?=
 =?us-ascii?Q?NqOSYilyFB9/1bzK3Vb7JWYDvMrlKQRMF2fPatqQop3qZUMb38Kuzm6M8irK?=
 =?us-ascii?Q?5RhWuilApFugSaNqW4YzXWop4uX2fGnIdt+upn+VjIUwzPQlEWahaVg/7m6g?=
 =?us-ascii?Q?RjxYAIkppU5GPL1JNThL9+bZKM1koRQWyTxJI+B8gf8uE85i3oFYxHuGM3Cc?=
 =?us-ascii?Q?fgb+5ZNQG+67KCP4rctHQ9/7tSxfS9VpZeQibnoAhvP/7iWtARhbbxfDcxIN?=
 =?us-ascii?Q?XuW5h8nPuoG0Pl2biHd/ps61is9UVsw+t9ehletxF1mDoDy38MhCP3895vYx?=
 =?us-ascii?Q?NUoN9OdbisCCwo2W+xUA08T8qdCS/Nwg+BIxZ8h927RnlEsgRsGqkMhoTbFu?=
 =?us-ascii?Q?02HUAjteL9YLhTLjG1vr/y9kyJqXiZFJEivOEEwISxjE9l4U7fJb7V0Qkt0w?=
 =?us-ascii?Q?w6X2vVCrmT0h2cZLhO4HIx/a0hCzjJCESTbgBo6g5WtI9jP8aQ=3D=3D?=
Content-Type: multipart/mixed;
        boundary="_002_BL0PR04MB6514EAAA034ADFFAFBF61CFCE74E9BL0PR04MB6514namp_"
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a0f901-6665-4172-2bdd-08d8ff91563c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 22:04:55.2501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9shZumAcOyDn0h4WfXxVfhYX7La9XJ4Y9RY66Kuz6eHH7w3mhNJtqGWjPc1qBP/xcyouyKsE4h5lh6e206m7Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4980
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--_002_BL0PR04MB6514EAAA034ADFFAFBF61CFCE74E9BL0PR04MB6514namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On 2021/04/14 23:11, Karel Zak wrote:=0A=
> On Wed, Apr 14, 2021 at 10:33:36AM +0900, Naohiro Aota wrote:=0A=
>> This series implements probing and wiping of the superblock of zoned btr=
fs.=0A=
> =0A=
> I have no disk with zones support, but it seems scsi_debug supports=0A=
> it. Do you have any step by step example how to test with btrfs? If=0A=
> yes, I will add a test to our test suite.=0A=
=0A=
Yes, scsi_debug does support emulating a ZBC disk. You can setup a disk lik=
e this:=0A=
=0A=
modprobe scsi_debug \=0A=
	max_luns=3D1 \=0A=
	sector_size=3D4096 \=0A=
	zbc=3Dhost-managed \=0A=
	dev_size_mb=3D2048 \=0A=
	zone_size_mb=3D64 \=0A=
	zone_nr_conv=3D0=0A=
=0A=
This will create a 2GB capacity disk with 64 MB zones.=0A=
Another solution, may be simpler, is to use null_blk. I am attaching a scri=
pt=0A=
that I use to create zoned null block devices.=0A=
=0A=
# nullblk-create.sh --help=0A=
Usage: nullblk-create.sh [options]=0A=
Options:=0A=
    -h | --help      : Display this help message and exit=0A=
    -v               : Be verbose (display final config)=0A=
    -cap <size (GB)> : set device capacity (default: 8)=0A=
                       For zoned devices, capacity is determined=0A=
                       with zone size and total number of zones=0A=
    -bs <size (B)>   : set sector size (default: 512)=0A=
    -m               : enable memory backing (default: false)=0A=
    -z               : create a zoned device (default: false)=0A=
    -qm <mode>       : set queue mode (default: 2)=0A=
                       0=3Dbio, 1=3Drq, 2=3Dmultiqueue=0A=
    -sq <num>        : set number of submission queues=0A=
                       (default: nproc)=0A=
    -qd <depth>      : set queue depth (default: 64)=0A=
    -im <mode>       : set IRQ mode (default: 0)=0A=
                       0=3Dnone, 1=3Dsoftirq, 2=3Dtimer=0A=
    -c <nsecs>       : set completion time for timer completion=0A=
                       (default: 10000 ns)=0A=
Options for zoned devices:=0A=
    -zs <size (MB)>  : set zone size (default: 8 MB)=0A=
    -zc <size (MB)>  : set zone capacity (default: zone size)=0A=
    -znc <num>       : set number of conv zones (default: 0)=0A=
    -zns <num>       : set number of swr zones (default: 8)=0A=
    -zr              : add a smaller runt swr zone (default: none)=0A=
    -zmo <num>       : set max open zones (default: no limit)=0A=
    -zma <num>       : set max active zones (default: no limit)=0A=
=0A=
Something like this:=0A=
=0A=
# nullblk-create.sh -m -cap 2 -z -zs 64 -znc 0=0A=
Created /dev/nullb0=0A=
=0A=
Will also create a 2GB capacity disk with memory backing and 64 MB zones.=
=0A=
=0A=
For the correct setup of the drive to test btrfs, I will let Naohiro and=0A=
Johannes comment.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=

--_002_BL0PR04MB6514EAAA034ADFFAFBF61CFCE74E9BL0PR04MB6514namp_
Content-Type: application/x-sh; name="nullblk-create.sh"
Content-Description: nullblk-create.sh
Content-Disposition: attachment; filename="nullblk-create.sh"; size=3574;
	creation-date="Wed, 14 Apr 2021 22:04:54 GMT";
	modification-date="Wed, 14 Apr 2021 22:04:54 GMT"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKCnNjcmlwdGRpcj0iJChjZCAiJChkaXJuYW1lICIkMCIpIiAmJiBwd2QpIgoK
ZnVuY3Rpb24gdXNhZ2UoKQp7CgllY2hvICJVc2FnZTogJChiYXNlbmFtZSAkMCkgW29wdGlvbnNd
IgoJZWNobyAiT3B0aW9uczoiCgllY2hvICIgICAgLWggfCAtLWhlbHAgICAgICA6IERpc3BsYXkg
dGhpcyBoZWxwIG1lc3NhZ2UgYW5kIGV4aXQiCgllY2hvICIgICAgLXYgICAgICAgICAgICAgICA6
IEJlIHZlcmJvc2UgKGRpc3BsYXkgZmluYWwgY29uZmlnKSIKCWVjaG8gIiAgICAtY2FwIDxzaXpl
IChHQik+IDogc2V0IGRldmljZSBjYXBhY2l0eSAoZGVmYXVsdDogOCkiCgllY2hvICIgICAgICAg
ICAgICAgICAgICAgICAgIEZvciB6b25lZCBkZXZpY2VzLCBjYXBhY2l0eSBpcyBkZXRlcm1pbmVk
IgoJZWNobyAiICAgICAgICAgICAgICAgICAgICAgICB3aXRoIHpvbmUgc2l6ZSBhbmQgdG90YWwg
bnVtYmVyIG9mIHpvbmVzIgoJZWNobyAiICAgIC1icyA8c2l6ZSAoQik+ICAgOiBzZXQgc2VjdG9y
IHNpemUgKGRlZmF1bHQ6IDUxMikiCgllY2hvICIgICAgLW0gICAgICAgICAgICAgICA6IGVuYWJs
ZSBtZW1vcnkgYmFja2luZyAoZGVmYXVsdDogZmFsc2UpIgoJZWNobyAiICAgIC16ICAgICAgICAg
ICAgICAgOiBjcmVhdGUgYSB6b25lZCBkZXZpY2UgKGRlZmF1bHQ6IGZhbHNlKSIKCWVjaG8gIiAg
ICAtcW0gPG1vZGU+ICAgICAgIDogc2V0IHF1ZXVlIG1vZGUgKGRlZmF1bHQ6IDIpIgoJZWNobyAi
ICAgICAgICAgICAgICAgICAgICAgICAwPWJpbywgMT1ycSwgMj1tdWx0aXF1ZXVlIgoJZWNobyAi
ICAgIC1zcSA8bnVtPiAgICAgICAgOiBzZXQgbnVtYmVyIG9mIHN1Ym1pc3Npb24gcXVldWVzIgoJ
ZWNobyAiICAgICAgICAgICAgICAgICAgICAgICAoZGVmYXVsdDogbnByb2MpIgoJZWNobyAiICAg
IC1xZCA8ZGVwdGg+ICAgICAgOiBzZXQgcXVldWUgZGVwdGggKGRlZmF1bHQ6IDY0KSIKCWVjaG8g
IiAgICAtaW0gPG1vZGU+ICAgICAgIDogc2V0IElSUSBtb2RlIChkZWZhdWx0OiAwKSIKCWVjaG8g
IiAgICAgICAgICAgICAgICAgICAgICAgMD1ub25lLCAxPXNvZnRpcnEsIDI9dGltZXIiCgllY2hv
ICIgICAgLWMgPG5zZWNzPiAgICAgICA6IHNldCBjb21wbGV0aW9uIHRpbWUgZm9yIHRpbWVyIGNv
bXBsZXRpb24iCgllY2hvICIgICAgICAgICAgICAgICAgICAgICAgIChkZWZhdWx0OiAxMDAwMCBu
cykiCgllY2hvICJPcHRpb25zIGZvciB6b25lZCBkZXZpY2VzOiIKCWVjaG8gIiAgICAtenMgPHNp
emUgKE1CKT4gIDogc2V0IHpvbmUgc2l6ZSAoZGVmYXVsdDogOCBNQikiCgllY2hvICIgICAgLXpj
IDxzaXplIChNQik+ICA6IHNldCB6b25lIGNhcGFjaXR5IChkZWZhdWx0OiB6b25lIHNpemUpIgoJ
ZWNobyAiICAgIC16bmMgPG51bT4gICAgICAgOiBzZXQgbnVtYmVyIG9mIGNvbnYgem9uZXMgKGRl
ZmF1bHQ6IDApIgoJZWNobyAiICAgIC16bnMgPG51bT4gICAgICAgOiBzZXQgbnVtYmVyIG9mIHN3
ciB6b25lcyAoZGVmYXVsdDogOCkiCgllY2hvICIgICAgLXpyICAgICAgICAgICAgICA6IGFkZCBh
IHNtYWxsZXIgcnVudCBzd3Igem9uZSAoZGVmYXVsdDogbm9uZSkiCgllY2hvICIgICAgLXptbyA8
bnVtPiAgICAgICA6IHNldCBtYXggb3BlbiB6b25lcyAoZGVmYXVsdDogbm8gbGltaXQpIgoJZWNo
byAiICAgIC16bWEgPG51bT4gICAgICAgOiBzZXQgbWF4IGFjdGl2ZSB6b25lcyAoZGVmYXVsdDog
bm8gbGltaXQpIgoKCWV4aXQgMAp9CgpmdW5jdGlvbiBnZXRfbnVsbGJfaWQoKQp7Cglsb2NhbCBu
aWQ9MAoKCXdoaWxlIFsgMSBdOyBkbwoJCWlmIFsgISAtYiAiL2Rldi9udWxsYiR7bmlkfSIgXTsg
dGhlbgoJCQlicmVhawoJCWZpCgkJbmlkPSQoKCBuaWQgKyAxICkpCglkb25lCgoJZWNobyAiJG5p
ZCIKfQoKIyBTZXQgY29uZmlnIGRlZmF1bHRzCmNhcD04CmJzPTUxMgptPTAKcW09MgpzcT0kKG5w
cm9jKQpxZD02NAppbT0wCmM9MTAwMDAKCno9MAp6cz04CnpjPTAKem5jPTAKem5zPTgKenI9MAp6
bW89MAp6bWE9MAoKdj0wCgojIFBhcnNlIGNvbW1hbmQgbGluZQp3aGlsZSBbWyAkIyAtZ3QgMCBd
XTsgZG8KCWNhc2UgIiQxIiBpbgoJIi1oIiB8ICItLWhlbHAiKQoJCXVzYWdlICIkMCIgOzsKCSIt
diIpCgkJdj0xIDs7CgkiLWNhcCIpCgkJc2hpZnQ7IGNhcD0kMSA7OwoJIi1icyIpCgkJc2hpZnQ7
IGJzPSQxIDs7CgkiLW0iKQoJCW09MSA7OwoJIi1xbSIpCgkJc2hpZnQ7IHFtPSQxIDs7CgkiLXNx
IikKCQlzaGlmdDsgc3E9JDEgOzsKCSItcWQiKQoJCXNoaWZ0OyBxZD0kMSA7OwoJIi1pbSIpCgkJ
c2hpZnQ7IGltPSQxIDs7CgkiLWMiKQoJCXNoaWZ0OyBjPSQxIDs7CgkiLXoiKQoJCXo9MSA7OwoJ
Ii16cyIpCgkJc2hpZnQ7IHpzPSQxIDs7CgkiLXpjIikKCQlzaGlmdDsgemM9JDEgOzsKCSItem5j
IikKCQlzaGlmdDsgem5jPSQxIDs7CgkiLXpucyIpCgkJc2hpZnQ7IHpucz0kMSA7OwoJIi16ciIp
CgkJenI9MSA7OwoJIi16bW8iKQoJCXNoaWZ0OyB6bW89JDEgOzsKCSItem1hIikKCQlzaGlmdDsg
em1hPSQxIDs7CgkqKQoJCWVjaG8gIkludmFsaWQgb3B0aW9uIFwiJDFcIiAodXNlIC1oIG9wdGlv
biBmb3IgaGVscCkiCgkJZXhpdCAxIDs7Cgllc2FjCgoJc2hpZnQKZG9uZQoKIyBDYWxjdWxhdGUg
em9uZWQgZGV2aWNlIGNhcGFjaXR5CmlmIFsgJHogPT0gMSBdOyB0aGVuCgljYXA9JCgoIHpzICog
KHpuYyArIHpucykgKSkKCWlmIFsgJHpyID09IDEgXTsgdGhlbgoJCWNhcD0kKCggZ2IgKyB6bnMg
LSAxICkpCglmaQplbHNlCgljYXA9JCgoIGNhcCAqIDEwMjQgKSkKZmkKCiMgQ3JlYXRlIGRldmlj
ZSBjb25maWcKbW9kcHJvYmUgbnVsbF9ibGsgbnJfZGV2aWNlcz0wIHx8IHJldHVybiAkPwpuaWQ9
JChnZXRfbnVsbGJfaWQpCmRldj0iL3N5cy9rZXJuZWwvY29uZmlnL251bGxiL251bGxiJHtuaWR9
Igpta2RpciAiJHtkZXZ9IgoKZWNobyAkY2FwID4gIiR7ZGV2fSIvc2l6ZQplY2hvICRicyA+ICIk
e2Rldn0iL2Jsb2Nrc2l6ZQplY2hvICRtID4gIiR7ZGV2fSIvbWVtb3J5X2JhY2tlZAplY2hvICRx
bSA+ICIke2Rldn0iL3F1ZXVlX21vZGUKZWNobyAkc3EgPiAiJHtkZXZ9Ii9zdWJtaXRfcXVldWVz
CmVjaG8gJHFkID4gIiR7ZGV2fSIvaHdfcXVldWVfZGVwdGgKZWNobyAkaW0gPiAiJHtkZXZ9Ii9p
cnFtb2RlCmlmIFsgJGltID09IDIgXTsgdGhlbgoJZWNobyAkYyA+ICIke2Rldn0iL2NvbXBsZXRp
b25fbnNlYwpmaQoKZWNobyAkeiA+ICIke2Rldn0iL3pvbmVkCmlmIFsgJHogPT0gMSBdOyB0aGVu
CgllY2hvICR6cyA+ICIke2Rldn0iL3pvbmVfc2l6ZQoJZWNobyAkemMgPiAiJHtkZXZ9Ii96b25l
X2NhcGFjaXR5CgllY2hvICR6bmMgPiAiJHtkZXZ9Ii96b25lX25yX2NvbnYKCWVjaG8gJHptbyA+
ICIke2Rldn0iL3pvbmVfbWF4X29wZW4KCWVjaG8gJHptYSA+ICIke2Rldn0iL3pvbmVfbWF4X2Fj
dGl2ZQpmaQoKIyBFbmFibGUgZGV2aWNlCmVjaG8gMSA+ICIke2Rldn0iL3Bvd2VyCmVjaG8gIkNy
ZWF0ZWQgL2Rldi9udWxsYiR7bmlkfSIKCmlmIFsgJHYgPT0gMSBdOyB0aGVuCgllY2hvICJEZXZp
Y2UgY29uZmlndXJhdGlvbjoiCglncmVwIC1yIC4gJHtkZXZ9CmZpCg==

--_002_BL0PR04MB6514EAAA034ADFFAFBF61CFCE74E9BL0PR04MB6514namp_--
