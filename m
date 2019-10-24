Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92ACAE3D07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 22:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfJXUQh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 16:16:37 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42698 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfJXUQg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 16:16:36 -0400
Received: by mail-yb1-f194.google.com with SMTP id 4so46812ybq.9;
        Thu, 24 Oct 2019 13:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YMSYLCRsA9TqdoiDz4AXX+A4t3eCYYmKlevH7QvgzHg=;
        b=VkQM1hK+EOYfJf1vms+5oVw+CAnGRtso+4y5ZLb0P2epeySC3M8yn52YBO9oC/XvCq
         oIetCALgJ4Bq8RgWHNB1L8LN5nVpQxTaJdZrRo8xlz0QyjRrtdwGIpyeYYeAX4hD25Kp
         zLnY2PdiN+b0k3gWtgrGVizNxY6IzZhXq4LzUb2nWwdNZcM6W8NaLoor1yz7q/ASDYr/
         hZxrPZizx6pHxBVmuffg/aIskfBaCaLpKgXNL8OOhpWrz00hxHcTRrpMzbc3nd+5cfsQ
         eXeXm97DzQ2n1WvwZMbcKGppBgs9ss0Gbhg9p8/Gk2hMh0kS0eHnoGp62oKSSRZSAWKR
         iM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YMSYLCRsA9TqdoiDz4AXX+A4t3eCYYmKlevH7QvgzHg=;
        b=EfjFlRY46xyndr0uIkb8SfgBdXUzOOM/4ThDpBAYh9foHkSbHV7CW31lJJErQJwAqx
         MoVz8K8MILbA4hiit1BeiTpF8U2oiXj7jSOY/WifNL15CmopyonULeBRYeT9MvuHbYcz
         gtXA0jxQ+k+lw5TB+tOl32aO+2BB5F7TbezwG6D5zlz+caMDiSwAFay9udL6ajtz74Nf
         TKk656Z1j+cnAS2TIjJfNmC4NsLuXYynU24JkXS9T3r/IPYcd+FDv+SS5u88vghec0Jd
         hcrMRl3kdxR9WMkrxnnf+Xmexiwh2yfPpoWXT5Hf+mQH1OuZQOgYznTZEFms1BESCjqf
         lIHg==
X-Gm-Message-State: APjAAAW8HEno7a2uPlxSc8quGQ/WSHccq5F86UegJaP2UkbloHZnivmC
        ovC8YAgjWcsIIFXKaeG4OrjjYZCh
X-Google-Smtp-Source: APXvYqwGhZe0d3pz6SBdvfOlja9QVhKf2zQyNCvEzA/qeAPIa1LxU+NJLLRcg9DaUuuNnXXYxwR7wg==
X-Received: by 2002:a05:6902:510:: with SMTP id x16mr147023ybs.324.1571948195222;
        Thu, 24 Oct 2019 13:16:35 -0700 (PDT)
Received: from anon-dhcp-153.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i5sm3838709ywe.110.2019.10.24.13.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2019 13:16:34 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC PATCH 00/35] user xattr support (RFC8276)
From:   Chuck Lever <chucklever@gmail.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
Date:   Thu, 24 Oct 2019 16:16:33 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9CAEB69A-A92C-47D8-9871-BA6EA83E1881@gmail.com>
References: <cover.1568309119.git.fllinden@amazon.com>
To:     Frank van der Linden <fllinden@amazon.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Frank-

> On Sep 12, 2019, at 1:25 PM, Frank van der Linden =
<fllinden@amazon.com> wrote:
>=20
> This RFC patch series implements both client and server side support
> for RFC8276 user extended attributes.
>=20
> The server side should be complete (except for modifications made
> after comments, of course). The client side lacks caching. I am
> working on that, but am not happy with my current implementation.
> So I'm sending this out for input. Having a reviewed base to work
> from will make adding client-side caching support easier to add,
> in any case.
>=20
> Thanks for any input!

This prototype looks very good. I have some general comments as I'm
getting to know your code. I assume your end goal is to get this
work merged into the upstream Linux kernel.

First some comments about patch submission and review:

- IMO you can post future updates just to linux-nfs. Note that the
kernel NFS client and server are maintained separately, so when it
comes time to submit final patches, you will send the client work
to Trond and Anna, and the server work to Bruce (and maybe me).

- We like patches that are as small as possible but no smaller.
Some of these might be too small. For example, you don't need to add
the XDR encoders, decoders, and reply size macros in separate patches.
That might help get the total patch count down without reducing
review-ability. I can help offline with other examples.

- Please run scripts/checkpatch.pl on each patch before you post
again. This will help identify coding convention issues that should
be addressed before merge. sparse is also a good idea too.
clang-format is also nice but is entirely optional.

- I was not able to get 34/35 to apply. The series might be missing
a patch that adds nfsd_getxattr and friends.

- Do you have man page updates for the new mount and export options?


Now some comments about code design:

- I'm not clear why new CONFIG options are necessary. These days we
try to avoid adding new CONFIG options if possible. I can't think of
a reason someone would need to compile user xattr support out if
NFSv4.2 is enabled.

- Can you explain why an NFS server administrator might want to
disable user xattr support on a share?

- Probably you are correct that the design choices you made regarding
multi-message LISTXATTR are the best that can be done. Hopefully that
is not a frequent operation, but for something like "tar" it might be.
Do you have any feeling for how to assess performance?

- Regarding client caching... the RFC is notably vague about what
is needed there. You might be able to get away with no caching, just
as a start. Do you (and others) think that this series would be
acceptable and mergeable without any client caching support?

- Do you have access to an RDMA-capable platform? RPC/RDMA needs to
be able to predict how large each reply will be, in order to reserve
appropriate memory resources to land the whole RPC reply on the client.
I'm wondering if you've found any particular areas where that might be
a challenge.


Testing:

- Does fstests already have user xattr functional tests? If not, how
do you envision testing this new code?

- How should we test the logic that deals with delegation recall?

- Do you have plans to submit patches to pyNFS?


> Some notable issues:
>=20
> * RFC8276 explicitly only concerns itself with the user xattr =
namespace.
>  Linux is the only OS that encodes the namespace in the attribute =
name,
>  adding "user." for the user namespace. Others, like FreeBSD and =
MacOS,
>  pass the namespace as a system call argument. Since the "user." =
prefix
>  is specific to Linux, it is stripped off on the client side, and =
added
>  back on the server side.
>=20
> * Extended attributes tend to be small in size, but they may be =
somewhat
>  large. The Linux-imposed limit is 64k. The sunrpc XDR interfaces only
>  allow sizes > PAGE_SIZE to be encoded using pages. That works out
>  great for reads/writes, but since there are no page-based xattr
>  FS interfaces, it means some extra explicit copying.
>=20
> * A quirk of the Linux xattr implementation is that you can create
>  more extended attributes per file than listxattr can handle in
>  its maximum size, meaning that you get E2BIG back. There is no
>  1-1 translation for that error to the LISTXATTR op. I chose to
>  return NFS4ERR_TOOSMALL (which is a valid error for the operation),
>  and have the client code check for it and return E2BIG. Not
>  great, but it seemed to be the best option.
>=20
> * The LISTXATTR op uses cookies to support multiple calls to retrieve
>  the complete list, like READDDIR. This means that there's the old
>  "how to deal with non-0 cookies" issue.
>=20
>  In the vast majority of cases, LISTXATTR should not need multiple
>  calls. However, you never know what a client will do. READDIR
>  uses the cookie as a seek offset in to the directory. It's not
>  quite as simple with LISTXATTR. First, there is no seperate
>  FS interface to list only user xattrs. Which means that, based
>  on permissions, the buffer returned by vfs_listxattr might turn
>  out differently (e.g. if you have no permission to read some
>  system. attributes). That means that using just a hard offset
>  in to the buffer (with verifications) can't work, as its a
>  context-specific value, and the client couldn't cache it if
>  it wanted to.
>=20
>  My code returns the attribute count as a cookie. The server
>  always asks vfs_listxattr for a XATTR_LIST_MAX buffer (see
>  below), and then starts XDR encoding at the Nth user xattr
>  attribute, where N is the cookie value. There are bounds
>  checks of course.
>=20
>  This isn't great, but probably the best you can do.
>=20
> * There is no FS interface to only read user extended attributes,
>  and the server code needs to strip off the "user." prefix.
>  Additionally, the RFC specifies that the max length field for the
>  LISTXATTR op refers to the total XDR-encoded length. Given all
>  this, it is not possible to know what the length is it should pass
>  to vfs_listxattr. So it just passes an XATTR_LIST_MAX sized buffer
>  to vfs_listxattr, and then encodes as many user xattrs as it can
>  from the returned buffer.
>=20
> * Given that this is an extension to v4.2, it is only supported
>  if 4.2 is used (even though it has no dependencies on 4.2
>  specific features).
>=20
> * There is a new mount option, already known for other filesystems,
>  "user_xattr", which must be passed explicitly as it stands
>  right now, together with vers=3D4.2
>=20
> * There is a new export option to turn off extended attributes for
>  a filesystem.
>=20
> * Modifications outside of the NFS(D) code were minor. They were
>  all in the xattr code, to export versions of vfs_setxattr and
>  vfs_removexattr that the NFS code should use (inode rwsem taken
>  because of atomic change info), and to have them break delegations,
>  as specified by RFC8276.
>=20
> * As I mentioned, this has no client caching. I have one =
implementation,
>  but I'm not that happy with it.
>=20
>  The main issue with client caching is that, for virtually all =
expected
>  cases, the number of user extended attributes per file will be small,
>  and their data small. But, theoretically, you can, within current =
Linux
>  limitations, create some 9000 user extended attributes per inode, =
each
>  64k in size.
>=20
>  My current implementation uses an inode LRU chain (much like the =
access
>  cache), and an rhashtable per inode (I picked rhashtables because
>  they automatically grow). This seems like overkill, though.
>=20
>  If there are any suggestions on better implementations, I'll be happy
>  to take them. The client caching I mention here is not in this =
series,
>  as I need to clean it up a bit (and am not sure if I really want to =
use
>  it). But I can share it if asked. It will be in the next iteration,
>  in whatever shape or form it might take.
>=20
> Frank van der Linden (35):
>  nfsd: make sure the nfsd4_ops array has the right size
>  nfs/nfsd: basic NFS4 extended attribute definitions
>  NFSv4.2: query the server for extended attribute support
>  nfs: parse the {no}user_xattr option
>  NFSv4.2: define a function to compute the maximum XDR size for
>    listxattr
>  NFSv4.2: define and set initial limits for extended attributes
>  NFSv4.2: define argument and response structures for xattr operations
>  NFSv4.2: define the encode/decode sizes for the XATTR operations
>  NFSv4.2: define and use extended attribute overhead sizes
>  NFSv4.2: add client side XDR handling for extended attributes
>  nfs: define nfs_access_get_cached function
>  NFSv4.2: query the extended attribute access bits
>  nfs: modify update_changeattr to deal with regular files
>  nfs: define and use the NFS_INO_INVALID_XATTR flag
>  nfs: make the buf_to_pages_noslab function available to the nfs code
>  NFSv4.2: add the extended attribute proc functions.
>  NFSv4.2: hook in the user extended attribute handlers
>  NFSv4.2: add client side xattr caching functions
>  NFSv4.2: call the xattr cache functions
>  nfs: add the NFS_V4_XATTR config option
>  xattr: modify vfs_{set,remove}xattr for NFS server use
>  nfsd: split off the write decode code in to a seperate function
>  nfsd: add defines for NFSv4.2 extended attribute support
>  nfsd: define xattr functions to call in to their vfs counterparts
>  nfsd: take xattr access bits in to account when checking
>  nfsd: add structure definitions for xattr requests / responses
>  nfsd: implement the xattr procedure functions.
>  nfsd: define xattr reply size functions
>  nfsd: add xattr XDR decode functions
>  nfsd: add xattr XDR encode functions
>  nfsd: add xattr operations to ops array
>  xattr: add a function to check if a namespace is supported
>  nfsd: add fattr support for user extended attributes
>  nfsd: add export flag to disable user extended attributes
>  nfsd: add NFSD_V4_XATTR config option
>=20
> fs/nfs/Kconfig                   |   9 +
> fs/nfs/Makefile                  |   1 +
> fs/nfs/client.c                  |  17 +-
> fs/nfs/dir.c                     |  24 +-
> fs/nfs/inode.c                   |   7 +-
> fs/nfs/internal.h                |  24 ++
> fs/nfs/nfs42.h                   |  29 ++
> fs/nfs/nfs42proc.c               | 242 ++++++++++++++
> fs/nfs/nfs42xattr.c              |  72 ++++
> fs/nfs/nfs42xdr.c                | 446 +++++++++++++++++++++++++
> fs/nfs/nfs4_fs.h                 |   5 +
> fs/nfs/nfs4client.c              |  31 ++
> fs/nfs/nfs4proc.c                | 246 ++++++++++++--
> fs/nfs/nfs4super.c               |   1 +
> fs/nfs/nfs4xdr.c                 |  35 ++
> fs/nfs/nfstrace.h                |   3 +-
> fs/nfs/super.c                   |  11 +
> fs/nfsd/Kconfig                  |  10 +
> fs/nfsd/export.c                 |   1 +
> fs/nfsd/nfs4proc.c               | 145 +++++++-
> fs/nfsd/nfs4xdr.c                | 548 +++++++++++++++++++++++++++++--
> fs/nfsd/nfsd.h                   |  13 +-
> fs/nfsd/vfs.c                    | 153 +++++++++
> fs/nfsd/vfs.h                    |  10 +
> fs/nfsd/xdr4.h                   |  31 ++
> fs/xattr.c                       |  90 ++++-
> include/linux/nfs4.h             |  27 +-
> include/linux/nfs_fs.h           |   6 +
> include/linux/nfs_fs_sb.h        |   7 +
> include/linux/nfs_xdr.h          |  62 +++-
> include/linux/xattr.h            |   4 +
> include/uapi/linux/nfs4.h        |   3 +
> include/uapi/linux/nfs_fs.h      |   1 +
> include/uapi/linux/nfsd/export.h |   3 +-
> 34 files changed, 2233 insertions(+), 84 deletions(-)
> create mode 100644 fs/nfs/nfs42xattr.c
>=20
> --=20
> 2.17.2
>=20

--
Chuck Lever
chucklever@gmail.com



