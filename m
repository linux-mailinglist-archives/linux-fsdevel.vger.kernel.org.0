Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8B82C216A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 10:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbgKXJab (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 04:30:31 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:60380 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgKXJaa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606210229; x=1637746229;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=sQVxAVdmAzdpK+TJO4f+yT6W0pm4Cob25UNQ1mDjBpk=;
  b=p+1FIrYQvebhNSdEhxB8Tu+pxlP6d8aTZC5JC7pMMn5l+hs2N2ISbUk+
   V9MOh0zPLcsc2fnn6S6Zf7D7Wuqyeq4YH2OEF0mw9+BiAvHsNTtuvDXGs
   yhJj9K0yCJiPpiVq6dZ19fZM0J1Nh5VD54p1xSCBBPeq2lRJ2CXlKN6GJ
   EZLhXFuqxu3MD5WfLrORkP5+I6yA8Hw/3Sj0dFXCP6NHSv4qzARPPuwIE
   B+YHbwShK1tY2tM3KZ3XZlbw601/jpJN5ewDGKnEx6/Gp6fWItsRupnxm
   q5PPefbYfL3EL/l+Ac8efgq/Nqvzc6Ux4zMxo8K3JmwwaOPlu4s7jiAG6
   A==;
IronPort-SDR: Yw6UTd4JSR5uY7H94W6yn2mHOnGdn3I0DW1jyaSNvHYAT2x7oXIjPzqebMB5FaKgQK258XZPce
 M2X58y7ETD2ySkrrLlmIroyZYRlC+pM37RAIesmquU5zF6raqmNbIZclPROBSXif7pzsqY2OpM
 TuCfdBS1rK3eFQ/19PcK55/TI1FVloVtNg8geU4peqItAfHNjH+zrFIE8GPoF7Sqc60ehxPttd
 kkPi1ByQCZ8P/BqAtaf8sbSH8OZABPN49NZBhl7whLJjLwIetDmrZ2kTSzQGWBCehJaTgNTQ+K
 pKQ=
X-IronPort-AV: E=Sophos;i="5.78,365,1599494400"; 
   d="scan'208";a="263387445"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2020 17:30:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXchohnCaZabj7aXfGuJv4whhqjaEp3BoaS9wbptfeIQHUhXMYb0CSr5AOC3vUgUJ5oeYIHs/Uzti3eTrJTUogoJmxoFfFXX7sleWCyokn1j+2FC36MdAwV563xcLfYUi3BfCIXgpRZ7Q54Bt3Mc1kYCWMug5xQHXt8ge6rhSldKsOrEmgcBlRStxBYsvUdAKe3C3KResMhAxoychQOEC/K4ybiKaeTGE8g1fuRIkVk7WF1H9fc79KsHU5a0ejpclRK25qWRDA9KrI/uA4gczlkTO/ZEg/VZ9+/RtQtQ+rNiT/rNTc5GdE8wJXK1bQD5B2080uDvzNoIKQYJU+ISEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSFNMcOkLQy4Kb+0RQLvQXIczNFUpCaNUdm4iY+/ciA=;
 b=ZHJrSWzRdFTHl2y5BuZrjCI8iQYeKzvRueKNHYbFkg9XryhoHFQh0uvFZLzzQqKm4nKi7bdLPuNN7oDA33Wji4ciZ3R0p3pj3iNfWg3LeQc2KCtt6vO9CtXNFKxQrrpXODZVJqxP7iL04VG6aNAO0C+u8k0xTaNTmBogKz8Gjit5hJP0vyL4yemi9FfiL1vU/bQFlxHdbFNHImAsKjRTtK9pYD0FNhjVb7Hff/+Vk098nu8RGJjpxggm/EY2hfQ2OTUiEYv5wNkSNpw7M0Yv6CsWnvXgGNTOTg4OZHUK1qcUNYJDArRGoSiMPhj1xkpamndVKjPUSXiZSjBlbRMwjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSFNMcOkLQy4Kb+0RQLvQXIczNFUpCaNUdm4iY+/ciA=;
 b=banagy1A7yff91Wt/rW10keERHmrYC3dmXiv4znZg70C4KdOO1QUfyw9jLvEs+k0FJzpEBecvO/JZ6r9K8eK/LE3EplxWmSVbMuuFK9vHLKi9rtztF/zKgzjOaDiiu5qdhLT2yIegO2+3UxDD7JZA1AsyerNOLQHja7QRbOaOuo=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA0PR04MB7323.namprd04.prod.outlook.com
 (2603:10b6:806:e5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Tue, 24 Nov
 2020 09:30:28 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 09:30:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v10 11/41] btrfs: implement log-structured superblock for
 ZONED mode
Thread-Topic: [PATCH v10 11/41] btrfs: implement log-structured superblock for
 ZONED mode
Thread-Index: AQHWt1SnTg7pu9wW+k2Bz9gbpZ4TNw==
Date:   Tue, 24 Nov 2020 09:30:28 +0000
Message-ID: <SN4PR0401MB3598A7DA2BF25A32811002079BFB0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <5aa30b45e2e29018e19e47181586f3f436759b69.1605007036.git.naohiro.aota@wdc.com>
 <20201123174630.GK8669@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b10c7ac5-229f-4dfe-8d16-08d8905b94b5
x-ms-traffictypediagnostic: SA0PR04MB7323:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR04MB7323974EBCD9F7A7309BB4019BFB0@SA0PR04MB7323.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ozj1MvJ0SjNS0uCZa5X9UrQEOQ8OwMl+RQyqPlcEYmP+elBM0wBq7BHH98WWMyG4NK+Wj4YcOIUX1SF+oNDIOss3edHuV8Da8Ea8Frz8H4YMCNpkNGWxzELUY8Zc1x3+QOa88POrdj7aC3ZH3074hxZu4Tdy31ZqfJ2TG9cB75MBj20FzM9iM8eyac/bliuxY8WoYWzuiswd9rRLi0GAHlaGFacOesTtW7zNm8NDK+Zb94BlQKQNSqMEkZ0yStScofs5IpzrM7EnrCM+MFYCEedr6VP+HCJ0NteKNYgMbZgpmjxX/9IWPdKLikO/kygyCd1dEfWmAhI/PVhg3np3JA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(55016002)(9686003)(86362001)(6636002)(5660300002)(7696005)(26005)(83380400001)(54906003)(71200400001)(110136005)(316002)(186003)(66446008)(66476007)(66946007)(33656002)(6506007)(66556008)(8676002)(76116006)(53546011)(478600001)(4326008)(91956017)(8936002)(2906002)(52536014)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ADZWur/WmmQ16k8cSbzddJTzZbEuyChYOgYA7OFYn7QlrnPjOM9H+VUBxQy8Z71WnXo5+dwiTr3dlpONub8nlh768/MktHq2EGjGpCf5v0PkZwLcDTouKxxkRO/DyeaCXBf9bnrZEnAA68Yb1kNHq5MYIVKUJsb+fykLT3NApiqOSHxBCE4/pwf/DmCHi5U38TgDRB05JVSiIa7uVXr9D8Ovpv3nnAczud1vW9w2ARM6dCp4odMUWQtzCx5Hw0i/yT0ncwaO0txD1XV3eASEST2Oyge1rVXBNfpCE9cya6WcToLJJEl+xUh/KWQiI7hVA9qpq2US1vrybZP/oHZgASxYZKoKFQDkaPaksYbmMPSeOgV5xfVppysOxlLcu70tmH9vDrYeVIbNlZM8443TpO5jXzX1WJAyVd3rbb74/XHoQa0qG1mt/aFOjmehV4pjDwI82ZOwHCH3ng+hLdeN+S3BnVsqpTaQ/PBMII5RoZGrf4xSdy8u/9QzcYNZMiSUV1qx01ya3CR6cyqz2wJOXM/ZZ1xPrClk92XhqQHjfPNi4wIUYkdwS3MaE32XogL5xIxpSKhy5uom6LVRamSglg5h29qC2Tgdg+IWxUmME+R3QPL4NBW1hOgjfrCDXc0GOYVX6fQzjAzgqN1ol8B+FLlDMuENK1wBn3XhNTp5GFTI1RUjWa6W23g+SVyebuU/nR3JhqCSJLbfRzHcHNdQshXi+BDsQcFdpaJq6Hdkg2W8t9dzKQmzCgiGLohjopqgKk1x+jD4RYi70wShsfr9hwxHcJBcEYSefbK8MT1LZktNQDtZeQrc1iszcRmUaIy+xiqEPEbw7GVFkcJvUJ+OGs0s51GmBdkMSgNqWLhlf3l9FQKSMpWO06K5dwmopEuVuMOogwFvkv1/7ZTRdFp+uw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10c7ac5-229f-4dfe-8d16-08d8905b94b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 09:30:28.3035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EnFtExxXs2Fm27jwNr9qqnhz08DNxmobC0fgpVgQkWFHIXhtOWq8qc9g1vzmMB4Hose6g/yLx6i3hl3Xv8abb3HqHND0zZkeoccYybxDs0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7323
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23/11/2020 18:49, David Sterba wrote:=0A=
> On Tue, Nov 10, 2020 at 08:26:14PM +0900, Naohiro Aota wrote:=0A=
>> Superblock (and its copies) is the only data structure in btrfs which ha=
s a=0A=
>> fixed location on a device. Since we cannot overwrite in a sequential wr=
ite=0A=
>> required zone, we cannot place superblock in the zone. One easy solution=
 is=0A=
>> limiting superblock and copies to be placed only in conventional zones.=
=0A=
>> However, this method has two downsides: one is reduced number of superbl=
ock=0A=
>> copies. The location of the second copy of superblock is 256GB, which is=
 in=0A=
>> a sequential write required zone on typical devices in the market today.=
=0A=
>> So, the number of superblock and copies is limited to be two.  Second=0A=
>> downside is that we cannot support devices which have no conventional zo=
nes=0A=
>> at all.=0A=
>>=0A=
>> To solve these two problems, we employ superblock log writing. It uses t=
wo=0A=
>> zones as a circular buffer to write updated superblocks. Once the first=
=0A=
>> zone is filled up, start writing into the second buffer. Then, when the=
=0A=
>> both zones are filled up and before start writing to the first zone agai=
n,=0A=
>> it reset the first zone.=0A=
>>=0A=
>> We can determine the position of the latest superblock by reading write=
=0A=
>> pointer information from a device. One corner case is when the both zone=
s=0A=
>> are full. For this situation, we read out the last superblock of each=0A=
>> zone, and compare them to determine which zone is older.=0A=
>>=0A=
>> The following zones are reserved as the circular buffer on ZONED btrfs.=
=0A=
>>=0A=
>> - The primary superblock: zones 0 and 1=0A=
>> - The first copy: zones 16 and 17=0A=
>> - The second copy: zones 1024 or zone at 256GB which is minimum, and nex=
t=0A=
>>   to it=0A=
> =0A=
> I was thinking about that, again. We need a specification. The above is=
=0A=
> too vague.=0A=
> =0A=
> - supported zone sizes=0A=
>   eg. if device has 256M, how does it work? I think we can support=0A=
>   zones from some range (256M-1G), where filling the zone will start=0A=
>   filing the other zone, leaving the remaining space empty if needed,=0A=
>   effectively reserving the logical range [0..2G] for superblock=0A=
> =0A=
> - related to the above, is it necessary to fill the whole zone?=0A=
>   if both zones are filled, assuming 1G zone size, do we really expect=0A=
>   the user to wait until 2G of data are read?=0A=
>   with average reading speed 150MB/s, reading 2G will take about 13=0A=
>   seconds, just to find the latest copy of the superblock(!)=0A=
> =0A=
> - what are exact offsets of the superblocks=0A=
>   primary (64K), ie. not from the beginning=0A=
>   as partitioning is not supported, nor bootloaders, we don't need to=0A=
>   worry about overwriting them=0A=
> =0A=
> - what is an application supposed to do when there's a garbage after a=0A=
>   sequence of valid superblocks (all zeros can be considered a valid=0A=
>   termination block)=0A=
> =0A=
> The idea is to provide enough information for a 3rd party tool to read=0A=
> the superblock (blkid, progs) and decouple the format from current=0A=
> hardware capabilities. If the zones are going to be large in the future=
=0A=
> we might consider allowing further flexibility, or fix the current zone=
=0A=
> maximum to 1G and in the future add a separate incompat bit that would=0A=
> extend the maximum to say 10G.=0A=
> =0A=
=0A=
We don't need to do that. All we need to do for finding the valid superbloc=
k=0A=
is a report zones call, get the write pointer and then read from =0A=
write-pointer - sizeof(struct brtfs_super_block). There is no need for scan=
ning=0A=
a whole zone. The last thing that was written will be right before the writ=
e=0A=
pointer.=0A=
