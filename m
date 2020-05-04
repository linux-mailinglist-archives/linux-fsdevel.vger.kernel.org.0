Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E75F1C367D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 12:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgEDKJu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 06:09:50 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:27326 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgEDKJt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 06:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588586988; x=1620122988;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=zuByB7Je9B7YUtz2F7H4pt5y4UP4EKJJF/nyuMhQXKE=;
  b=FkW2ZyfhP6Yy7LkvzQHxlHiFlpoLRIyPPNyrC25LlHr6rMXpxiHbT/LK
   KQev4OwGXOpYe8315JOuXcla28p/a6spNEht5R2zPkwrm31shOJ0yAAFu
   PkxgnyVFZhafJqrdyL5TuXLY5LTrrtUWZMJMALE+Onf1+BQ8hpbKUYP+f
   aJbSW3US6CkiNOLBqX0XdR+VjAbetfA+bs8untsDOSGpiP+u7s4eftPyj
   fhUEgbZD+idRRc+8IWYat2OZbr2DZAEik/C27Hd+S0kSlwqVLJiI/m9UV
   DeQvhcyxk4Zvzp6FrPPdMhTdjWN/ldQqX2Mk+vPxBTl0MM9tdaTUnh+Rs
   Q==;
IronPort-SDR: Ei/32eEib0Kkutr9RrzjQN41OmxW46FVq/K7MZXGgpoH5UxVWohaBARF80EumjJT4ZmN1RA0r+
 1sNXAi8kV77EnCNsapMU5tKrhEoVQqP6wAKILciXTPHjq7hDzIWYmhvt6d3VliX9AcX38iFcQQ
 Bi94JiWieb38QjLyXCCHJXxm3GslGa6zaMBF2aLQCmPTw776Pt/bRjAPR7uqTWJE3LybI+O6k9
 XzIV9GpE7zedJ1utGBJ6Cc28So9dw4gTLQxGj96Th+HXRy/AoylR9cLCklgyW0bnWIPxaczxIR
 EYo=
X-IronPort-AV: E=Sophos;i="5.73,351,1583164800"; 
   d="scan'208";a="136868939"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2020 18:09:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9Rk0fAA9PxZQkyOWpp2DOYUt8H5nw+wfAlNRuvPuKdJ+haFz4MF4wIiAXrd7v0D28bCq7zx47drQxKkIdB9s3LsXTaKKfzNiGP3syxoAMEdvLp+ey0eRcxkrgRylDp3X46exKHAUYHsPYUd3NnvokbqfWIjMb3rqiRYdNtyAj3jz3LctEChu3ArYtS2sok4xdxKmppaG7Uo+p7LDXnaHJinvU3VDqRv3hd9xmwni4e4dYgKc6i0MBvPf3u6yZEVubXWBo8Z0ZzTDfadSEadZHXD27TWE3MuP5YICQ2ASukikNC9r48fOoaXd7SxI0IxoMZBlOOseIDdnrif5FzuSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEn4R72vp1PytBHN2h+5F7hqhETLFGQLQi2MKt7JyJc=;
 b=Bls0yI3jU/Zmvl5MSEqlxffP+roYUhM/EQNJuZ2zl6KfSaIxsbYGqGaMU52PzaP57EWTUGC3KEqPEZ8zGBMPClQeN+Ae89+kyPId32sj9WR7weBQPYa6qea2WKvxfIQ09PjIMRG6jfQ/+5KuFHXADEQZbu6kq7DIZX6SmuBYv0iq6Sj9kvoV7wL2hhY3fDPiiHIBSgsNHCv1axk8/rWwsyFeJwvzHEv5n9BYir9ByeiR6hLWiCUsfDckzPREEXULqFaASmt0G9l7OnPOanPSA8LlTbWdkUsH+M5FH6v3X690dikcAx1L4ds0OaTzHYffNaLzipvPs+nmwNVzAjjm3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEn4R72vp1PytBHN2h+5F7hqhETLFGQLQi2MKt7JyJc=;
 b=ckW8G6f6M8U4WMc6MEOgSCjDUr0Rbclm8Iiy0X8E5dzFm1i8htbxyV3yeJMxImsSdrK8hcl1tQXDmgOZ6Ni9EhOxZFmJtTpvm7MZ5SGklNTCyM/qPr2jlaHDc8E6QPFd49d2S+Z8buinH/YNKMh13+i/N6fnFrGdYRkB17G0bNI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3550.namprd04.prod.outlook.com
 (2603:10b6:803:46::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Mon, 4 May
 2020 10:09:44 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2958.029; Mon, 4 May 2020
 10:09:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Eric Biggers <ebiggers@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>
CC:     David Sterba <dsterba@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
Thread-Topic: [PATCH v2 1/2] btrfs: add authentication support
Thread-Index: AQHWHUw3Fjk34p8J2kWvUrIfOj4HzQ==
Date:   Mon, 4 May 2020 10:09:44 +0000
Message-ID: <SN4PR0401MB3598198E5FB728B68B39A1589BA60@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200428105859.4719-1-jth@kernel.org>
 <20200428105859.4719-2-jth@kernel.org>
 <20200501053908.GC1003@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea004bc5-ff7f-4b2b-aa1f-08d7f01344e1
x-ms-traffictypediagnostic: SN4PR0401MB3550:
x-microsoft-antispam-prvs: <SN4PR0401MB35507578A50C668068CE48929BA60@SN4PR0401MB3550.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 03932714EB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iOmQ8Dz/y8dEMHZfxYghvRYVPIlrBFubtvJeuM/qMvQ66UYFf2XtE2uPRa4eYxYdbKO0DfS/WKo1YwJYEEHaiTQrxXo/Km/VJCCoPv7LKdqODG2phU9/wCVHJCjowr3S0yK7Ppbg2FjuSnBaymKfMLwclX0L4vfsE4XhHcNCf923gLj5L4gPToPvRqk+6Ge8vTrNE/BHLQJ2JvoATj0Ft40YvYtLTuwgqRIgngo8iIFC7glR6oyp4xCDivbA68oMDXMIaTVF8hDfiG/Uo8b5ulf+nLBO+ps6gXCSVWIU2BvNfGeMeiefrfakXbezXfd5BG6XowfgK4DfqsrnQamYThk8LJqMIVD9PsLmF6vtsnNj42lqHD6wSFiG8EHltGTSHcOixJQFKbXZgJSFJKzsR1WxLIU8mgEABvHK+XewwAar1curhOG8QnQoUlmZHDR7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(2906002)(53546011)(7696005)(4326008)(91956017)(6506007)(76116006)(71200400001)(66446008)(66556008)(64756008)(66476007)(110136005)(186003)(316002)(26005)(52536014)(54906003)(33656002)(8936002)(8676002)(66946007)(55016002)(478600001)(5660300002)(86362001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: gTU3U+WSGxfLR8mq/OyL/vjww7s4y+35Z4lmxKCwCoA9w4LIJAcprvUIny+8O/lP4EyGPZocLE8SUGnOrXrCSSuJ/WzRr3YX5bQZquhoQAy3uVeZBd1vQHtzI5YQI1lFREDr8cqkbKzHaKNT3tM7UZrzIZTlDYfXeXFm1vdGJu534h5kjyvrcdK0V/oNVzfmmqvtpTK5Y3+kDPm5eh2liAjTyEigee8eA0T16UjoYHC/nYSemMB/fx9JJD4wc2q057D5sOU5cqYW2GdBH2oAa89ukkC37zmCdH4RmEblUllw1uL2lkgjy9qAGZ+BfxYxKQFjuue8MwxP9yABIDmojWIvdVHKIQakVBgf6XWjr9LvKQfOiD1Q/RZ7jsFLc5cHlyXzQKpGtFeE7j7IQAJKejXziu2LhD92g0dJEPD/PaOmmG4k8v6K8Z0UK8Gb5dsGsuvEZi6V0BejazTSluaNncKrLwMiBgcpuuQ+AzyU0tFnMCUkCQ6paFZKTLjw6YSOWkbgXn/z9Rk6HcIe4CfQP3tezVtI5D4W2y2+PAv9p7lOOmvJRZdGYSjSMMKYiRbOaztflZJKOELn6RY90+06HUHg5y465TBDk2YFne5G+hLXchY+ebwT0ihCb8cqqxv3vm5hrkFHDyUHKGPKt9U4YsFy2SCMLlJ4udcLfBJCsSgEUYMS3pTKRKL9sx4/GvKxKNRFpVVVoQQCY2Bz1VL2g4jqy0Ng1n5jSrxQ4FnFbsdgieB4oyYhnRTkQA3PMpHbrLYIi/64vcBotA57TggnQNVOGdLYxkU5mf3nINbRiXM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea004bc5-ff7f-4b2b-aa1f-08d7f01344e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2020 10:09:44.5440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3IBC49aL0Q4Zt/5Zi4l70Ql/1QccGjVPIRvgNPGZ+bcxv1kgyM5rjCYG4kSPNgha2qDEYjcWt7GgeDMFYQx5QzQZiumSiQb5E1s0qmXrq0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3550
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/05/2020 07:39, Eric Biggers wrote:=0A=
[...]=0A=
=0A=
Thanks for taking the time to look through this.=0A=
=0A=
> =0A=
> This is a good idea, but can you explain exactly what security properties=
 you=0A=
> aim to achieve?=0A=
=0A=
My goal is to protect the file-system against offline modifications. =0A=
Offline in this context means when the filesystem is not mounted.=0A=
=0A=
This could be a switched off laptop in a hotel room or a container =0A=
image, or a powered off embedded system. When the file-system is mounted =
=0A=
normal read/write access is possible.=0A=
=0A=
> As far as I can tell, btrfs hashes each data block individually.  There's=
 no=0A=
> contextual information about where eaech block is located or which file(s=
) it=0A=
> belongs to.  So, with this proposal, an attacker can still replace any da=
ta=0A=
> block with any other data block.  Is that what you have in mind?  Have yo=
u=0A=
> considered including contextual information in the hashes, to prevent thi=
s?=0A=
> =0A=
> What about metadata blocks -- how well are they authenticated?  Can they =
be=0A=
> moved around?  And does this proposal authenticate *everything* on the=0A=
> filesystem, or is there any part that is missed?  What about the superblo=
ck?=0A=
=0A=
In btrfs every metadata block is started by a checksum (see struct =0A=
btrfs_header or struct btrfs_super_block). This checksum protects the =0A=
whole meta-data block (minus the checksum field, obviously).=0A=
=0A=
The two main structure of the trees are btrfs_node and btrfs_leaf (both =0A=
started by a btrfs_header). struct btrfs_node holds the generation and =0A=
the block pointers of child nodes (and leafs). Struct btrfs_leaf holds =0A=
the items, which can be inodes, directories, extents, checksums, =0A=
block-groups, etc...=0A=
=0A=
As each FS meta-data item, beginning with the super block, downwards to =0A=
the meta-data items themselves is protected be a checksum, so the FS =0A=
tree (including locations, generation, etc) is protected by a checksum, =0A=
for which the attacker would need to know the key to generate.=0A=
=0A=
The checksum for data blocks is saved in a separate on-disk btree, the =0A=
checksum tree. The structure of the checksum tree consists of =0A=
btrfs_leafs and btrfs_nodes as well, both of which do have a =0A=
btrfs_header and thus are protected by the checksums.=0A=
=0A=
> =0A=
> You also mentioned preventing replay of filesystem operations, which sugg=
ests=0A=
> you're trying to achieve rollback protection.  But actually this scheme d=
oesn't=0A=
> provide rollback protection.  For one, an attacker can always just rollba=
ck the=0A=
> entire filesystem to a previous state.=0A=
=0A=
You're right, replay is the wrong wording there and it's actually =0A=
harmful in the used context. What I had in mind was, in order to change =0A=
the structure of the filesystem, an attacker would need the key to =0A=
update the checksums, otherwise the next read will detect a corruption.=0A=
=0A=
As for a real replay case, an attacker would need to increase the =0A=
generation of the tree block, in order to roll back to a older state, an =
=0A=
attacker still would need to modify the super-block's generation, which =0A=
is protected by the checksum as well.=0A=
=0A=
> This feature would still be useful even with the above limitations.  But =
what is=0A=
> your goal exactly?  Can this be made better?=0A=
> =0A=
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c=0A=
>> index d10c7be10f3b..fe403fb62178 100644=0A=
>> --- a/fs/btrfs/disk-io.c=0A=
>> +++ b/fs/btrfs/disk-io.c=0A=
>> @@ -17,6 +17,7 @@=0A=
>>   #include <linux/error-injection.h>=0A=
>>   #include <linux/crc32c.h>=0A=
>>   #include <linux/sched/mm.h>=0A=
>> +#include <keys/user-type.h>=0A=
>>   #include <asm/unaligned.h>=0A=
>>   #include <crypto/hash.h>=0A=
>>   #include "ctree.h"=0A=
>> @@ -339,6 +340,7 @@ static bool btrfs_supported_super_csum(u16 csum_type=
)=0A=
>>   	case BTRFS_CSUM_TYPE_XXHASH:=0A=
>>   	case BTRFS_CSUM_TYPE_SHA256:=0A=
>>   	case BTRFS_CSUM_TYPE_BLAKE2:=0A=
>> +	case BTRFS_CSUM_TYPE_HMAC_SHA256:=0A=
>>   		return true;=0A=
>>   	default:=0A=
>>   		return false;=0A=
>> @@ -2187,6 +2189,9 @@ static int btrfs_init_csum_hash(struct btrfs_fs_in=
fo *fs_info, u16 csum_type)=0A=
>>   {=0A=
>>   	struct crypto_shash *csum_shash;=0A=
>>   	const char *csum_driver =3D btrfs_super_csum_driver(csum_type);=0A=
>> +	struct key *key;=0A=
>> +	const struct user_key_payload *ukp;=0A=
>> +	int err =3D 0;=0A=
>>   =0A=
>>   	csum_shash =3D crypto_alloc_shash(csum_driver, 0, 0);=0A=
>>   =0A=
>> @@ -2198,7 +2203,53 @@ static int btrfs_init_csum_hash(struct btrfs_fs_i=
nfo *fs_info, u16 csum_type)=0A=
>>   =0A=
>>   	fs_info->csum_shash =3D csum_shash;=0A=
>>   =0A=
>> -	return 0;=0A=
>> +	/*=0A=
>> +	 * if we're not doing authentication, we're done by now. Still we have=
=0A=
>> +	 * to validate the possible combinations of BTRFS_MOUNT_AUTH_KEY and=
=0A=
>> +	 * keyed hashes.=0A=
>> +	 */=0A=
>> +	if (csum_type =3D=3D BTRFS_CSUM_TYPE_HMAC_SHA256 &&=0A=
>> +	    !btrfs_test_opt(fs_info, AUTH_KEY)) {=0A=
>> +		crypto_free_shash(fs_info->csum_shash);=0A=
>> +		return -EINVAL;=0A=
> =0A=
> Seems there should be an error message here that says that a key is neede=
d.=0A=
> =0A=
>> +	} else if (btrfs_test_opt(fs_info, AUTH_KEY)=0A=
>> +		   && csum_type !=3D BTRFS_CSUM_TYPE_HMAC_SHA256) {=0A=
>> +		crypto_free_shash(fs_info->csum_shash);=0A=
>> +		return -EINVAL;=0A=
> =0A=
> The hash algorithm needs to be passed as a mount option.  Otherwise the a=
ttacker=0A=
> gets to choose it for you among all the supported keyed hash algorithms, =
as soon=0A=
> as support for a second one is added.  Maybe use 'auth_hash_name' like UB=
IFS=0A=
> does?=0A=
=0A=
Can you elaborate a bit more on that? As far as I know, UBIFS doesn't =0A=
save the 'auth_hash_name' on disk, whereas 'BTRFS_CSUM_TYPE_HMAC_SHA256' =
=0A=
is part of the on-disk format. As soon as we add a 2nd keyed hash, say =0A=
BTRFS_CSUM_TYPE_BLAKE2B_KEYED, this will be in the superblock as well, =0A=
as struct btrfs_super_block::csum_type.=0A=
=0A=
> =0A=
>> +	} else if (!btrfs_test_opt(fs_info, AUTH_KEY)) {=0A=
>> +		/*=0A=
>> +		 * This is the normal case, if noone want's authentication and=0A=
>> +		 * doesn't have a keyed hash, we're done.=0A=
>> +		 */=0A=
>> +		return 0;=0A=
>> +	}=0A=
>> +=0A=
>> +	key =3D request_key(&key_type_logon, fs_info->auth_key_name, NULL);=0A=
>> +	if (IS_ERR(key))=0A=
>> +		return PTR_ERR(key);=0A=
> =0A=
> Seems this should print an error message if the key can't be found.=0A=
> =0A=
> Also, this should enforce that the key description uses a service prefix =
by=0A=
> formatting it as kasprintf("btrfs:%s", fs_info->auth_key_name).  Otherwis=
e=0A=
> people can abuse this feature to use keys that were added for other kerne=
l=0A=
> features.  (This already got screwed up elsewhere, which makes the "logon=
" key=0A=
> type a bit of a disaster.  But there's no need to make it worse.)=0A=
=0A=
OK, will do.=0A=
