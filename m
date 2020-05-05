Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF501C5216
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 11:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgEEJn6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 05:43:58 -0400
Received: from mout.gmx.net ([212.227.15.19]:49425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbgEEJn5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 05:43:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588671820;
        bh=eE1yF7fXo6Tgk8HdA1oJoVbg7bjRaL3TdTgZa5um/ZA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=iAmdplwgbQTfY197DC3LYVawM/6N4T5ABQQxTiXBLAE3EUk0TrFsI8MGuUOPqbBCG
         DbN/GS4vwkh9Ix825r6dKWFyaLRTy3pK9FYxvC/r0xlxrEARP6CWh7vxNWJTFB6nJy
         LEHHXn8M7a56wluSGpqtUxORbcyFvMwKQ3tRXsxw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEFzr-1jNtEs1rQD-00AD6T; Tue, 05
 May 2020 11:43:40 +0200
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
To:     Johannes Thumshirn <jth@kernel.org>, David Sterba <dsterba@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20200428105859.4719-1-jth@kernel.org>
 <20200428105859.4719-2-jth@kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <bcd4e839-36ac-9be5-e5e7-613124385177@gmx.com>
Date:   Tue, 5 May 2020 17:43:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428105859.4719-2-jth@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wmyu1bRindwld3n5R2qxihSx0KNuZhvsx"
X-Provags-ID: V03:K1:vK9ojIpTs9swq0qPEHUD62MThzurA+2ko5X6PbU44qNoYS9NgST
 86/FBIycTefGw78zzT3lrnUQ01NbbRfhgf82C0EqPOynPhw91uw/m2PnlwwQT2ZwfinQiXG
 SSe65I35Hg7tzbisz+XTshV1c7QXg3wn/nKCpwHa5y0HQnLjJbpxbXrl6smfvZZ4ycNtUgu
 S7oL89ZO3Y8aOMiEYQJhg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:m3w3sStAcLE=:RGpBK8wv/J0FWWXoPn/jRI
 qukV4MES506ceRTPsHOUXEb5GZRCcir8aUDKaGUlRZlNnjCu9gRJhKQhpGu4jL2uxkAE541IC
 XfYXu+DqIHdRHKlB1lN2PvOyorRa1MAom19L86tUzxpyjCHPn3KJHLqeC0k91ZfRz3Ry5UHZZ
 FDZ6K4G3ooAcfAvywfu6AHqnWo/NgO9CuRfL+TMQVbNnvo8SauIOf5gMDFycdo3k30lY956xT
 5tnIFgvCmpRQRULpXv6n1E8rWjO+DVWj25EH5qwq0X8X4l3C11JdXmGJS7dzmSXYuwayVVkIB
 pKtK3Bh/mWQDsPDFFFKQqQNPIDu8/QCd6E1MaPRs6V5Obz2obkNeupApr2vct5EU1gjT0Oide
 O7G3kAoBQnBPlDUZfQ4mPy5tR3JD94B+xl3UTGgEuBJ7Glzu78vOZf4W/0MdYqnkP1CJgpg9N
 VoENr+QpRV5BL0xL2mBGZQaXmrvlwoMipqtnkj0S8yW7R7jpn2lGFgjdspRi+gRrJbTQurCYO
 hgzWjtdXkaZY34oUYARJpELSMlYtfxFzenAQZ8KUIDhYEAwuikWG5lUJO3+DQ7mAbAqYfdjQO
 t3Z+pgk05WrulmjfTtxx6JLoH4ICJMx0CYQTXm+QWJ3eolfeQGIsQ3vtZ/afk9/uQQeY+j+LP
 gY720xzgVebjzyiDFIXA27ey2WwK+1Oh5ECxbW3Snvi4ZeUrPYQXZ1txiGju4JuAuIx8ghWLO
 t2SGEI4chamOSke3gdrfS5MH7Ge1aIqKyWs1VWYnknufxh7MsFs+Gk7RVU1pn/bV2RpW5VaD/
 u9XEDND3udYxHaGanUt8z1nPw4LSavlXTT3h0Ujvm9UKb6fREw8rAGR7cqp+qEeJxxcgKVD/v
 FeVu9FP4HFvYIca4NuDN/pdw72A4tyxt2rXqFU2Boc6Jjw0B7eXp8/CHu6+AUNwS8Q1Ab3jm2
 /vXXj1z7GCADjHqiazK+XEZQvVBYYseSrpHK4JuxGoLO1ww9ISRLqtyoS8wBCjYLX7xGOa1Fr
 PPZBNAN6bb8G10WvK66jiDfOBDiw22vDuBo8hm0DPlNjPmd9D/K8h46cYLdshwHg+gDh41x+e
 aM0NXKJFRxl20MQoEFw7qK9doRGhtttAxPotbp/Pk0FpLGmEzWa1ccUvBl4U4qAOY3igtY73S
 ry1LQeZuD3vYT2eIzMWfVUafG9b1r/Ni94MFVxkV2oy9k+8gCu42Fifu5jWu5wuqxbjfGnRBp
 251oiPAuRcfaOTQcD
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wmyu1bRindwld3n5R2qxihSx0KNuZhvsx
Content-Type: multipart/mixed; boundary="igxWT3yY1n0w54us7KpkvwmamrwDIO67v"

--igxWT3yY1n0w54us7KpkvwmamrwDIO67v
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/4/28 =E4=B8=8B=E5=8D=886:58, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>=20
> Add authentication support for a BTRFS file-system.
>=20
> This works, because in BTRFS every meta-data block as well as every
> data-block has a own checksum. For meta-data the checksum is in the
> meta-data node itself. For data blocks, the checksums are stored in the=

> checksum tree.
>=20
> When replacing the checksum algorithm with a keyed hash, like HMAC(SHA2=
56),
> a key is needed to mount a verified file-system. This key also needs to=
 be
> used at file-system creation time.
>=20
> We have to used a keyed hash scheme, in contrast to doing a normal
> cryptographic hash, to guarantee integrity of the file system, as a
> potential attacker could just replay file-system operations and the
> changes would go unnoticed.
>=20
> Having a keyed hash only on the topmost Node of a tree or even just in =
the
> super-block and using cryptographic hashes on the normal meta-data node=
s
> and checksum tree entries doesn't work either, as the BTRFS B-Tree's No=
des
> do not include the checksums of their respective child nodes, but only =
the
> block pointers and offsets where to find them on disk.
>=20
> Also note, we do not need a incompat R/O flag for this, because if an o=
ld
> kernel tries to mount an authenticated file-system it will fail the
> initial checksum type verification and thus refuses to mount.
>=20
> The key has to be supplied by the kernel's keyring and the method of
> getting the key securely into the kernel is not subject of this patch.
>=20
> Example usage:
> Create a file-system with authentication key 0123456
> mkfs.btrfs --csum hmac-sha256 --auth-key 0123456 /dev/disk
>=20
> Add the key to the kernel's keyring as keyid 'btrfs:foo'
> keyctl add logon btrfs:foo 0123456 @u
>=20
> Mount the fs using the 'btrfs:foo' key
> mount -t btrfs -o auth_key=3Dbtrfs:foo /dev/disk /mnt/point
>=20
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Looks pretty straight forward, and has the basic protection against
re-writing all csum attack.

So looks good to me.

But still I have one question around the device scan part.

Since now superblock can only be read after verified the csum, it means
without auth_key mount option, device scan won't even work properly.

Do you assume that all such hmac protected multi-device btrfs must be
mounted using device=3D mount option along with auth_key?
If so, a lot of users won't be that happy afaik.

Thanks,
Qu

> ---
>  fs/btrfs/ctree.c                |  3 ++-
>  fs/btrfs/ctree.h                |  2 ++
>  fs/btrfs/disk-io.c              | 53 +++++++++++++++++++++++++++++++++=
+++++++-
>  fs/btrfs/super.c                | 24 ++++++++++++++++---
>  include/uapi/linux/btrfs_tree.h |  1 +
>  5 files changed, 78 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 6c28efe5b14a..76418b5b00a6 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -31,7 +31,7 @@ static void del_ptr(struct btrfs_root *root, struct b=
trfs_path *path,
> =20
>  static const struct btrfs_csums {
>  	u16		size;
> -	const char	name[10];
> +	const char	name[12];
>  	const char	driver[12];
>  } btrfs_csums[] =3D {
>  	[BTRFS_CSUM_TYPE_CRC32] =3D { .size =3D 4, .name =3D "crc32c" },
> @@ -39,6 +39,7 @@ static const struct btrfs_csums {
>  	[BTRFS_CSUM_TYPE_SHA256] =3D { .size =3D 32, .name =3D "sha256" },
>  	[BTRFS_CSUM_TYPE_BLAKE2] =3D { .size =3D 32, .name =3D "blake2b",
>  				     .driver =3D "blake2b-256" },
> +	[BTRFS_CSUM_TYPE_HMAC_SHA256] =3D { .size =3D 32, .name =3D "hmac(sha=
256)" }
>  };
> =20
>  int btrfs_super_csum_size(const struct btrfs_super_block *s)
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index c79e0b0eac54..b692b3dc4593 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -719,6 +719,7 @@ struct btrfs_fs_info {
>  	struct rb_root swapfile_pins;
> =20
>  	struct crypto_shash *csum_shash;
> +	char *auth_key_name;
> =20
>  	/*
>  	 * Number of send operations in progress.
> @@ -1027,6 +1028,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const stru=
ct btrfs_fs_info *info)
>  #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
>  #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
>  #define BTRFS_MOUNT_DISCARD_ASYNC	(1 << 29)
> +#define BTRFS_MOUNT_AUTH_KEY		(1 << 30)
> =20
>  #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
>  #define BTRFS_DEFAULT_MAX_INLINE	(2048)
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index d10c7be10f3b..fe403fb62178 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -17,6 +17,7 @@
>  #include <linux/error-injection.h>
>  #include <linux/crc32c.h>
>  #include <linux/sched/mm.h>
> +#include <keys/user-type.h>
>  #include <asm/unaligned.h>
>  #include <crypto/hash.h>
>  #include "ctree.h"
> @@ -339,6 +340,7 @@ static bool btrfs_supported_super_csum(u16 csum_typ=
e)
>  	case BTRFS_CSUM_TYPE_XXHASH:
>  	case BTRFS_CSUM_TYPE_SHA256:
>  	case BTRFS_CSUM_TYPE_BLAKE2:
> +	case BTRFS_CSUM_TYPE_HMAC_SHA256:
>  		return true;
>  	default:
>  		return false;
> @@ -2187,6 +2189,9 @@ static int btrfs_init_csum_hash(struct btrfs_fs_i=
nfo *fs_info, u16 csum_type)
>  {
>  	struct crypto_shash *csum_shash;
>  	const char *csum_driver =3D btrfs_super_csum_driver(csum_type);
> +	struct key *key;
> +	const struct user_key_payload *ukp;
> +	int err =3D 0;
> =20
>  	csum_shash =3D crypto_alloc_shash(csum_driver, 0, 0);
> =20
> @@ -2198,7 +2203,53 @@ static int btrfs_init_csum_hash(struct btrfs_fs_=
info *fs_info, u16 csum_type)
> =20
>  	fs_info->csum_shash =3D csum_shash;
> =20
> -	return 0;
> +	/*
> +	 * if we're not doing authentication, we're done by now. Still we hav=
e
> +	 * to validate the possible combinations of BTRFS_MOUNT_AUTH_KEY and
> +	 * keyed hashes.
> +	 */
> +	if (csum_type =3D=3D BTRFS_CSUM_TYPE_HMAC_SHA256 &&
> +	    !btrfs_test_opt(fs_info, AUTH_KEY)) {
> +		crypto_free_shash(fs_info->csum_shash);
> +		return -EINVAL;
> +	} else if (btrfs_test_opt(fs_info, AUTH_KEY)
> +		   && csum_type !=3D BTRFS_CSUM_TYPE_HMAC_SHA256) {
> +		crypto_free_shash(fs_info->csum_shash);
> +		return -EINVAL;
> +	} else if (!btrfs_test_opt(fs_info, AUTH_KEY)) {
> +		/*
> +		 * This is the normal case, if noone want's authentication and
> +		 * doesn't have a keyed hash, we're done.
> +		 */
> +		return 0;
> +	}
> +
> +	key =3D request_key(&key_type_logon, fs_info->auth_key_name, NULL);
> +	if (IS_ERR(key))
> +		return PTR_ERR(key);
> +
> +	down_read(&key->sem);
> +
> +	ukp =3D user_key_payload_locked(key);
> +	if (!ukp) {
> +		btrfs_err(fs_info, "");
> +		err =3D -EKEYREVOKED;
> +		goto out;
> +	}
> +
> +	err =3D crypto_shash_setkey(fs_info->csum_shash, ukp->data, ukp->data=
len);
> +	if (err)
> +		btrfs_err(fs_info, "error setting key %s for verification",
> +			  fs_info->auth_key_name);
> +
> +out:
> +	if (err)
> +		crypto_free_shash(fs_info->csum_shash);
> +
> +	up_read(&key->sem);
> +	key_put(key);
> +
> +	return err;
>  }
> =20
>  static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 7932d8d07cff..2645a9cee8d1 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -333,6 +333,7 @@ enum {
>  	Opt_treelog, Opt_notreelog,
>  	Opt_usebackuproot,
>  	Opt_user_subvol_rm_allowed,
> +	Opt_auth_key,
> =20
>  	/* Deprecated options */
>  	Opt_alloc_start,
> @@ -401,6 +402,7 @@ static const match_table_t tokens =3D {
>  	{Opt_notreelog, "notreelog"},
>  	{Opt_usebackuproot, "usebackuproot"},
>  	{Opt_user_subvol_rm_allowed, "user_subvol_rm_allowed"},
> +	{Opt_auth_key, "auth_key=3D%s"},
> =20
>  	/* Deprecated options */
>  	{Opt_alloc_start, "alloc_start=3D%s"},
> @@ -910,7 +912,8 @@ int btrfs_parse_options(struct btrfs_fs_info *info,=
 char *options,
>   * All other options will be parsed on much later in the mount process=
 and
>   * only when we need to allocate a new super block.
>   */
> -static int btrfs_parse_device_options(const char *options, fmode_t fla=
gs,
> +static int btrfs_parse_device_options(struct btrfs_fs_info *info,
> +				      const char *options, fmode_t flags,
>  				      void *holder)
>  {
>  	substring_t args[MAX_OPT_ARGS];
> @@ -939,7 +942,8 @@ static int btrfs_parse_device_options(const char *o=
ptions, fmode_t flags,
>  			continue;
> =20
>  		token =3D match_token(p, tokens, args);
> -		if (token =3D=3D Opt_device) {
> +		switch (token) {
> +		case Opt_device:
>  			device_name =3D match_strdup(&args[0]);
>  			if (!device_name) {
>  				error =3D -ENOMEM;
> @@ -952,6 +956,18 @@ static int btrfs_parse_device_options(const char *=
options, fmode_t flags,
>  				error =3D PTR_ERR(device);
>  				goto out;
>  			}
> +			break;
> +		case Opt_auth_key:
> +			info->auth_key_name =3D match_strdup(&args[0]);
> +			if (!info->auth_key_name) {
> +				error =3D -ENOMEM;
> +				goto out;
> +			}
> +			btrfs_info(info, "doing authentication");
> +			btrfs_set_opt(info->mount_opt, AUTH_KEY);
> +			break;
> +		default:
> +			break;
>  		}
>  	}
> =20
> @@ -1394,6 +1410,8 @@ static int btrfs_show_options(struct seq_file *se=
q, struct dentry *dentry)
>  #endif
>  	if (btrfs_test_opt(info, REF_VERIFY))
>  		seq_puts(seq, ",ref_verify");
> +	if (btrfs_test_opt(info, AUTH_KEY))
> +		seq_printf(seq, ",auth_key=3D%s", info->auth_key_name);
>  	seq_printf(seq, ",subvolid=3D%llu",
>  		  BTRFS_I(d_inode(dentry))->root->root_key.objectid);
>  	seq_puts(seq, ",subvol=3D");
> @@ -1542,7 +1560,7 @@ static struct dentry *btrfs_mount_root(struct fil=
e_system_type *fs_type,
>  	}
> =20
>  	mutex_lock(&uuid_mutex);
> -	error =3D btrfs_parse_device_options(data, mode, fs_type);
> +	error =3D btrfs_parse_device_options(fs_info, data, mode, fs_type);
>  	if (error) {
>  		mutex_unlock(&uuid_mutex);
>  		goto error_fs_info;
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs=
_tree.h
> index a02318e4d2a9..bfaf127b37fd 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -344,6 +344,7 @@ enum btrfs_csum_type {
>  	BTRFS_CSUM_TYPE_XXHASH	=3D 1,
>  	BTRFS_CSUM_TYPE_SHA256	=3D 2,
>  	BTRFS_CSUM_TYPE_BLAKE2	=3D 3,
> +	BTRFS_CSUM_TYPE_HMAC_SHA256 =3D 32,
>  };
> =20
>  /*
>=20


--igxWT3yY1n0w54us7KpkvwmamrwDIO67v--

--wmyu1bRindwld3n5R2qxihSx0KNuZhvsx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl6xNUQACgkQwj2R86El
/qijsAf/cqmRmrh3Q3XxpXQ+0P5riaDNyGat16TQUToJBRem1K89aWzvCpSC+SOL
ZYfK9WI/MvGW6EqdpUDJNmwSEj5J7c6YHqqnwMM4IplEw5NhHcGKPJJ0XwSjRIad
/MqLE1ukLmBw5kvkJ8QdviFNzuqiNUS1qEkHF/b+0u2FA02BPUvO4UAqFRmADhlG
am5NrDGlC5S9nn2mjLc2/eodUS24WEfjvXsF/U8qbWu8M4yU1i/pXTNwAG30HFrS
l7ghQyxDp2sZG2xISzodNliIdpBEAc1PxZZoLTV7HNMc7rr5d2ovEuXOKplYG7dp
pldNoNS/pLtJc44zOrIRO3q+CcxJQg==
=yFyt
-----END PGP SIGNATURE-----

--wmyu1bRindwld3n5R2qxihSx0KNuZhvsx--
