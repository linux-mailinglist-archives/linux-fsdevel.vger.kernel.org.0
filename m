Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 867FF153CB8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 02:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgBFBml (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 20:42:41 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:31611 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgBFBml (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 20:42:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580953360; x=1612489360;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=DxbbsjgNnLy00FUtc9tdPN17Hp3kvpINf1l+70fFIxo=;
  b=RKZueekk1sbit7KhppBDscxmCp5V55tExqyNvrMBHZ4K3BCywS9qK6w6
   8YlEmgCc10jKYu3fL2iYzvTn+rHsLAbomCxo0sr4c/ObDoRMzdR9DCd1g
   vg7rNgeznOEyLhPfWcfD5R7JPMI1M5Ei6CuYZuxiVtvYwRbfgMdEdJgef
   W7j9OYerv71PNiubjG31Tls0rhNNokDz3M72cL9ogkhjRiAwDRjbr0aus
   WuQGJh+tfWqKQrXft1a32YiaywN2hX5aiDqm0Ip/EydFLwGLR0ePjiS5h
   zr8mTXF431+P+CYAkggZKOYAmbHelZcNo3bpHcTeizEp3hTR1n5y5sLua
   Q==;
IronPort-SDR: idu9VomdfDjeBwo/hO1pOHkpMTgWYvU435+iwnj/BlqoeGHdAQidqi9tiDrSBQgqd4rp3jTW8U
 wppAOoNkofKpjLiR8V/CipOSe27Rliv3+9/b60s4aEpMdKuqDKjcb/ADtPcb/Rch2sbU4A54mr
 9Z50HYP13GxO2AeF58kfeYz3hRjVE7XFTpi+fy+3hPXhpquxDbqyiH521+ar7wtDgopbA7CINk
 dpQPW1VEvCZoUW3sy57CFy6mYq/lK1GH/UC1OotgmUyin97D6Yg+GN7h5AxxAqRVcS6y2fSRTD
 d0k=
X-IronPort-AV: E=Sophos;i="5.70,407,1574092800"; 
   d="scan'208";a="130667458"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 09:42:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAfBnBrdxzBKCNR+U7Hs0LsJHWmbxswWdHPRumgKsiKNUAa7H1DN613BuIKaGS5ofqVwTojX6OC0ouuJCifZJhNGgUGwleFisvKKIp5HEz6fwoAupMn9bvV009M4pmYuF0rJrG0mIKbK6pp9j69JN3lV4F2xnruCACqO68phlDtZxAySCzftosJY64hLBionWffPwBhgDTKXOZp+yOZSIpqW/hiNpd5JE98K5dCrS0DTRVOAJaq4FXFkMSqPtQ0CXTAFqbYTASD42o0AR87coWzvLa3HjbLW0MAWAsUOOHMShGykOKlmYz53cpNh9Etujt9otLMo34ikKKaakDZUyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+V2Jl+fVbtlMy6MEYgrkzjolTefVfWtyyJuhTLJ56M=;
 b=ZvO8K/A8oquRzUJE8BRhEgcqvyZ1AYW+zb7m1HXNpIfQcyGoJRU6YNAH0cAZVU8KfSU5BSK6TssHu7Cl3S/ecScMP3SSm0M3qz1VwxB7YRya/jb7LAgSkAk8RLqaMjtRiYuGIhBFl5ALtJysU6ZFcudDvr/i8CmDtzuSQJ7KDwpCeqrSObJb/E5QaEz3NHTgqE5ac99/L42F/R3Eq5Q5kC961XP1spNou6SCYVclSypp4T2jo41quOt8+VPzgbIOsCn4ztR1SVxzpqeidjs/Jm1EUrELpmCnTJx9NBgZ7ybntajLHnCB8PH1uwxAq2GeqfXTLCSlYYZ3dcE0DjTp7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+V2Jl+fVbtlMy6MEYgrkzjolTefVfWtyyJuhTLJ56M=;
 b=OBjyWh7bEXHPIcjR+GC9s5Gf7gTPLTJGCabHHyfikPADHiQFDZPPRIsY2cIfmSOEf7nOIIjzOhyeqCwoehb56cutNb/H6nz1Ujs5mhsfKDI96uHOaAT7V+eqLJlEpBYi88QnWpWBQHpf98LNgMiQlENE5NvTOxO8LySQzw4kdn8=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4486.namprd04.prod.outlook.com (52.135.237.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Thu, 6 Feb 2020 01:42:37 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2707.023; Thu, 6 Feb 2020
 01:42:37 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v11 2/2] zonefs: Add documentation
Thread-Topic: [PATCH v11 2/2] zonefs: Add documentation
Thread-Index: AQHV3B0L5p2DldaRKE+TK2eBqinZNw==
Date:   Thu, 6 Feb 2020 01:42:37 +0000
Message-ID: <BYAPR04MB58166109650A2DC8D61FB6DDE71D0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20200205120837.67798-1-damien.lemoal@wdc.com>
 <20200205120837.67798-3-damien.lemoal@wdc.com>
 <20200205222947.GN20628@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 921eb00d-5185-4cd6-7725-08d7aaa5d87b
x-ms-traffictypediagnostic: BYAPR04MB4486:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB44869F5ABB2EFD66ADB7DAB3E71D0@BYAPR04MB4486.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(4326008)(76116006)(7696005)(91956017)(6916009)(8936002)(86362001)(8676002)(81156014)(81166006)(9686003)(55016002)(33656002)(71200400001)(478600001)(54906003)(316002)(66476007)(66446008)(66946007)(2906002)(64756008)(66556008)(52536014)(53546011)(26005)(5660300002)(186003)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4486;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S+pQaUumLixdWo0jOl4VNL08fQ+6TGgQ/uMvrtUcxDEsa5iD0Uvz1KjAQHT8jCcqOWzm19ReJxhoTOEdKp8pRFSohNq6OrClgh1fYYYMd6Cl3JVBwnBCy3xgOY8p7XYQkNSf+zkN1kIN0TAaH07kxWb19SveoUVCamUVGyegyKSOhLDECKvpi9S7lXNIit/lsxMDdMvzodKuQBX2SVqYCKO1mJSpof1vOkWEfFNtoAkp2dofz+NfZ7fNTPQdC5LP0sWmexV1j3vJEfzCpFJ/xssUkJsrhoe8t0W061HM3FMHUHoHj3w/MhN4nTluqVcU+hbzoX3gVvJ2hoCBsShBV6flT+u/pVWhXMCeW4EgI5TYqHPsNcWcv36LtI3lZEBnMA2iUkFw6aHtR8UrvxfM0HuGTIxOiDZWIGfrCicscvRfbgRwp4KqUNNkziAbf6tV
x-ms-exchange-antispam-messagedata: yPLLiSSxcUSbZaNP44DmPq3KzACRMBnu2vIg+i/rxV58QJgeHs3aSu8Ppm7ZthbFo9tzOxaf10Daf/4tlF7WNp/wgLqNXF5HLpwKGZEI6gxNPUQjz2cC3pKj52o3pdWx3kc5OcmVZYZMw+EHLVASVA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921eb00d-5185-4cd6-7725-08d7aaa5d87b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 01:42:37.3650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vh76iZreMT9vI/fiywdpzbVYY7uSkVaOqz7fhqGsn5omb7MseKr7CN6XFYBY9ExiAtAaRgNfIi+16jPr2PMcQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4486
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/02/06 7:29, Dave Chinner wrote:=0A=
> On Wed, Feb 05, 2020 at 09:08:37PM +0900, Damien Le Moal wrote:=0A=
>> Add the new file Documentation/filesystems/zonefs.txt to document=0A=
>> zonefs principles and user-space tool usage.=0A=
>>=0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> .....=0A=
> =0A=
> Just looking at the error handling text...=0A=
> =0A=
>> +Several optional features of zonefs can be enabled at format time.=0A=
>> +* Conventional zone aggregation: ranges of contiguous conventional zone=
s can be=0A=
>> +  aggregated into a single larger file instead of the default one file =
per zone.=0A=
>> +* File ownership: The owner UID and GID of zone files is by default 0 (=
root)=0A=
>> +  but can be changed to any valid UID/GID.=0A=
>> +* File access permissions: the default 640 access permissions can be ch=
anged.=0A=
>> +=0A=
>> +zonefs mount options=0A=
>> +--------------------=0A=
> =0A=
> This section is really all about error handling, not so much mount=0A=
> options in general...=0A=
=0A=
Indeed. Section title fix is needed.=0A=
=0A=
> =0A=
>> +=0A=
>> +zonefs defines several mount options allowing the user to control the f=
ile=0A=
>> +system behavior when write I/O errors occur and when inconsistencies be=
tween a=0A=
>> +file size and its zone write pointer position are discovered. The handl=
ing of=0A=
>> +read I/O errors is not changed by these options as long as no inode siz=
e=0A=
>> +corruption is detected.=0A=
>> +=0A=
>> +These options are as follows.=0A=
>> +* errors=3Dremount-ro (default)=0A=
>> +  All write IO errors and errors due to a zone of the device going "bad=
"=0A=
>> +  (condition changed to offline or read-only), the file system is remou=
nted=0A=
>> +  read-only after fixing the size and access permissions of the inode t=
hat=0A=
>> +  suffered the IO error.=0A=
> =0A=
> What does "fixing the size and access permissions of the inode"=0A=
> mean?=0A=
> =0A=
>> +* errors=3Dzone-ro=0A=
>> +  Any write IO error to a file zone result in the zone being considered=
 as in a=0A=
>> +  read-only condition, preventing any further modification to the file.=
 This=0A=
>> +  option does not affect the handling of errors due to offline zones. F=
or these=0A=
>> +  zones, all accesses (read and write) are disabled.=0A=
> =0A=
> If the zone is marked RO, then shouldn't reads still work?. Oh, hold=0A=
> on, you're now talking about errors that take the zone oflfine at=0A=
> the device level?=0A=
> =0A=
> Perhaps a table describing what IO can be done to a zone vs the=0A=
> device once an error occurs would be a clearer way of describing the=0A=
> behaviour.=0A=
> =0A=
> =0A=
> It seems to me that a table might be a better way of decribing all=0A=
> the different conditions=0A=
> =0A=
> 				Post error access permissions=0A=
> 				   zone		    device=0A=
> mountopt	zone state	read	write	read	write=0A=
> --------	----------	----	-----	----	-----=0A=
> remount-ro	good		yes	no	yes	no=0A=
> 		RO		yes	no	yes	no=0A=
> 		Offline		no	no	yes	no=0A=
> =0A=
> zone-ro		good		yes	no	yes	yes=0A=
> 		RO		yes	no	yes	yes=0A=
> 		Offline		no	no	yes	yes=0A=
> =0A=
> zone-offline	good		no	no	yes	yes=0A=
> 		RO		no	no	yes	yes=0A=
> 		Offline		no	no	yes	yes=0A=
> =0A=
> repair		good		yes	yes	yes	yes=0A=
> 		RO		yes	no	yes	yes=0A=
> 		Offline		no	no	yes	yes=0A=
> =0A=
> And then you can document that an offline zone will always appear to=0A=
> have a size of 0, be immutable, etc, while a read-only zone will=0A=
> have a size that reflects the amount of valid data in the zone that=0A=
> can be read.=0A=
> =0A=
> IOWs, you don't need to mix the definitions of zone state appearence=0A=
> and behaviour with descriptions of what actions the different mount=0A=
> options take when a write error occurs.=0A=
=0A=
Excellent idea ! That will clarify things a lot.=0A=
=0A=
>> +* errors=3Dzone-offline=0A=
>> +  Any write IO error to a file zone result in the zone being considered=
 as in=0A=
>> +  an offline condition. This implies that the file size is changed to 0=
 and all=0A=
>> +  read/write accesses to the file disabled, preventing all accesses by =
the user.=0A=
>> +* errors=3Drepair=0A=
>> +  Any inconsistency between an inode size and its zone amount of writte=
n data=0A=
>> +  due to IO errors or external corruption are fixed without any change =
to file=0A=
>> +  access rights. This option does not affect the processing of zones th=
at were=0A=
>> +  signaled as read-only or offline by the device. For read-only zones, =
the file=0A=
>> +  read accesses are disabled and for offline zones, all access permissi=
ons are=0A=
>> +  removed.=0A=
>> +=0A=
>> +For sequential zone files, inconsistencies between an inode size and th=
e amount=0A=
>> +of data writen in its zone, that is, the position of the file zone writ=
e=0A=
>> +pointer, can result from different events:=0A=
>> +* When the device write cache is enabled, a differed write error can oc=
cur=0A=
> =0A=
> "a different write error"?=0A=
=0A=
Nope. I really meant differed, as in "delayed" since the write command=0A=
succeeded but the cache flush for the data passed by the already completed=
=0A=
write command fails later. The sentence is not clear. I will clarify this=
=0A=
error pattern.=0A=
=0A=
> =0A=
>> +  resulting in the amount of data written in the zone being less than t=
he inode=0A=
>> +  size.=0A=
> =0A=
> Though I suspect that what you really mean to say is that errors can=0A=
> occur in ranges of previously completed writes can occur when the=0A=
> cache is flushed, hence less data being physically written than the=0A=
> OS has previously be told was written by the hardware. i.e. visible=0A=
> inode size goes backwards.=0A=
=0A=
Yes, exactly. I will copy-paste this very clear explanation :)=0A=
=0A=
>> +Finally, defective drives may change the condition of any zone to offli=
ne (zone=0A=
>> +dead) or read-only. Such changes, when discovered with the IO errors th=
ey can=0A=
>> +cause, are handled automatically regardless of the options specified at=
 mount=0A=
>> +time. For offline zones, the action taken is similar to the action defi=
ned by=0A=
>> +the errors=3Dzone-offline mount option. For read-only zones, the action=
 used is=0A=
>> +as defined by the errors=3Dzone-ro mount option.=0A=
> =0A=
> Hmmmm. I think that's over-complicating things and takes control of=0A=
> error handling away from the user. That is, regardless of the reason=0A=
> for the error, if we get a write error and the user specified=0A=
> errors=3Dremount-ro, the entire device should go read-only because=0A=
> that's what the user has told the filesystem to do on write error.=0A=
=0A=
Yes, and that is the case. Any IO error with errors=3Dremount-ro will turn=
=0A=
the FS read-only. What I tried to say here is that this option will not=0A=
affect the handling of zones that went offline (done by the device). For=0A=
these, the file will not even be read-only. The table will clarify that. I=
=0A=
also need to clarify the different causes for errors, e.g. "regular"=0A=
read-write errors due to bad sectors, excessive vibrations, etc, which are=
=0A=
generally recoverable (rewrite over bad sectors fixes the sector most of=0A=
the time) and the ones due to the device changing zones condition, which=0A=
are not recoverable (no condition can get these zones out of their bad stat=
e).=0A=
=0A=
> This seems pretty user-unfriendly - giving them a way to control=0A=
> error handling behaviour and then ignoring it for specific errors=0A=
> despite the fact they mean exactly the same thing to the user: the=0A=
> write failed because a zone has gone bad since the last time that=0A=
> zone was accessed by the application....=0A=
=0A=
I think it is only the explanation that is bad. The error control mount=0A=
options are enforced correctly as defined.=0A=
=0A=
Thanks !=0A=
=0A=
> =0A=
> Cheers,=0A=
> =0A=
> Dave.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
