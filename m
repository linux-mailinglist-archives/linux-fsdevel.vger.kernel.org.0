Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76BF58A289
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Aug 2022 22:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbiHDUtA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Aug 2022 16:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiHDUs7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Aug 2022 16:48:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07036D9F6;
        Thu,  4 Aug 2022 13:48:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7168DB8271D;
        Thu,  4 Aug 2022 20:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246F8C433C1;
        Thu,  4 Aug 2022 20:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659646136;
        bh=RNRJXdFBE6JxbLLO/D/xPVCUajRCsSHqe+4kKjldfjE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Knx6C4OOhLxDw5sRj1wWHuba0DjVMJ/cw34GWYyt9qHt6px9XsF0x78g3+2kI/gzl
         OVkjI0uTSb7d4i5A0fQ1PVjnKvSxdJpe2Eyb6sMVDoMQBEMdTWUDfDR3F5EawB236P
         rWFKpwig9kbDuXLVCplBv4/hCqhRT6SPlTyspAecfnX52EMXMa8HoJnBoVWcwN5gvX
         yEhUcDja+QfRh5sOQXXbi8+H72PXEHLPA6jLREPF7++lHKHLvGzg/Ktp09oSrozGyu
         /3FbcQT8w6IsQoeCFNIflQD1GTvbQo3dwSf2rV3YuXDUvOhQesKgHoGRos6fpRrmck
         NVkTg/jLdAhRA==
Message-ID: <809ae8167a074e9e50d6102453339a7b21932b7f.camel@kernel.org>
Subject: Re: [RFC PATCH 0/3] Rename "cifs" module to "smbfs"
From:   Jeff Layton <jlayton@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Enzo Matsumiya <ematsumiya@suse.de>, Tom Talpey <tom@talpey.com>,
        linux-cifs@vger.kernel.org, smfrench@gmail.com, pc@cjr.nz,
        ronniesahlberg@gmail.com, nspmangalore@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        samba-technical@lists.samba.org, pshilovsky@samba.org
Date:   Thu, 04 Aug 2022 16:48:53 -0400
In-Reply-To: <Yuwq0kUJMTAX6F4m@casper.infradead.org>
References: <20220801190933.27197-1-ematsumiya@suse.de>
         <c05f4fc668fa97e737758ab03030d7170c0edbd9.camel@kernel.org>
         <20220802193620.dyvt5qiszm2pobsr@cyberdelia>
         <6f3479265b446d180d71832fd0c12650b908ebe2.camel@kernel.org>
         <1c2e8880-3efe-b55d-ee50-87d57efc3130@talpey.com>
         <20220803015655.7u5b6i4eo5sfnryb@cyberdelia>
         <cf24d6b5496598e7717428c6bdcb2366a7d49529.camel@kernel.org>
         <Yuwq0kUJMTAX6F4m@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-08-04 at 21:23 +0100, Matthew Wilcox wrote:
> On Thu, Aug 04, 2022 at 03:03:23PM -0400, Jeff Layton wrote:
> > On Tue, 2022-08-02 at 22:56 -0300, Enzo Matsumiya wrote:
> > > On 08/02, Tom Talpey wrote:
> > > > The initial goal is to modularize the SMB1 code, so it can be compl=
etely
> > > > removed from a running system. The extensive refactoring logically =
leads
> > > > to this directory renaming, but renaming is basically a side effect=
.
> > > >=20
> >=20
> > This is a great technical goal. Splitting up cifs.ko into smaller
> > modules would be great, in addition to being able to turn off smb1
> > support.
>=20
> I don't know the CIFS module that well.  How do you see it being split
> up?  It's #4 in the list of filesystems:
>=20

Probably by SMB protocol version, similar to how nfs.ko was split. Some
of the files are already version-specific. Some others will need to be
split up or moved into a common helper module, etc. It's not as
mechanical a change, but it would be nice to move in that direction.

To be clear for Enzo, if you have to do enough moving things around,
then it may make sense to go ahead and rename the directory too. It sort
of depends on what the final delta looks like.

> $ size /lib/modules/5.18.0-3-amd64/kernel/fs/*/*.ko |sort -n |tail
>  369020	  28460	    132	 397612	  6112c	/lib/modules/5.18.0-3-amd64/kerne=
l/fs/ubifs/ubifs.ko
>  395793	  50398	    960	 447151	  6d2af	/lib/modules/5.18.0-3-amd64/kerne=
l/fs/ceph/ceph.ko
>  477909	  58883	  10512	 547304	  859e8	/lib/modules/5.18.0-3-amd64/kerne=
l/fs/nfsd/nfsd.ko
>  609260	  84848	    640	 694748	  a99dc	/lib/modules/5.18.0-3-amd64/kerne=
l/fs/f2fs/f2fs.ko
>  622638	 252078	   1008	 875724	  d5ccc	/lib/modules/5.18.0-3-amd64/kerne=
l/fs/nfs/nfsv4.ko
>  717343	 111314	   1176	 829833	  ca989	/lib/modules/5.18.0-3-amd64/kerne=
l/fs/ext4/ext4.ko
>  884247	 206051	    504	1090802	 10a4f2	/lib/modules/5.18.0-3-amd64/kerne=
l/fs/cifs/cifs.ko
>  890155	 159520	    240	1049915	 10053b	/lib/modules/5.18.0-3-amd64/kerne=
l/fs/ocfs2/ocfs2.ko
> 1193834	 274148	    456	1468438	 166816	/lib/modules/5.18.0-3-amd64/kerne=
l/fs/xfs/xfs.ko
> 1393088	 126501	  15072	1534661	 176ac5	/lib/modules/5.18.0-3-amd64/kerne=
l/fs/btrfs/btrfs.ko
>=20
> ... but if you look at how NFS is split up:
>=20
>  311322	  76200	    392	 387914	  5eb4a	/lib/modules/5.18.0-3-amd64/kerne=
l/fs/nfs/nfs.ko
>   25157	   1100	     72	  26329	   66d9	/lib/modules/5.18.0-3-amd64/kerne=
l/fs/nfs/nfsv2.ko
>   49332	   1544	    120	  50996	   c734	/lib/modules/5.18.0-3-amd64/kerne=
l/fs/nfs/nfsv3.ko
>  622638	 252078	   1008	 875724	  d5ccc	/lib/modules/5.18.0-3-amd64/kerne=
l/fs/nfs/nfsv4.ko
>=20
> you can save a lot of RAM if you don't need NFSv4 (then there's also
> nfs_common, 408kB of sunrpc.ko, etc, etc).

The memory savings is nice, but the real gain is in being able to
eventually drop SMB1 support. The SMB1 protocol is notoriously awful, so
there is legitimate interest in doing so. Moving it into a separate
module (built under a new Kconfig option) would be a great first step in
that direction.

--=20
Jeff Layton <jlayton@kernel.org>
