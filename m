Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3381B7B2AC0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 05:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjI2Dub (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 23:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjI2Du2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 23:50:28 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA77F19F;
        Thu, 28 Sep 2023 20:50:25 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7741c5bac51so767066085a.1;
        Thu, 28 Sep 2023 20:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695959425; x=1696564225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYYbHmRBUQu7YjfKhJdocL7dPfjriCkGg2JwzJsWdwM=;
        b=OgS0+rHVheAoiR5EnChiZq2pVgkTwoqklKOc2O2TXqKHvKq8kU2A7Wz5bYw1kGtFqI
         aqXIefdua592BhK8tIohJ8bNNn5WQlaegSE0cLv9wCLeW1C5R2pivJS8Z81dN5avSQK9
         yKR0a7PRt86/Rm3KerAawe/6QQQGfdflrGMJa7sjwn7MHNR5TJUAtSZZ/g9f6fkQMvgW
         vD/sMK5JqyNJXDSKWVkoZpNdpzIHMdlCjB7daouB4b+BgkZry7wqQ+lKghcMaG5hqDFI
         7VZcrZAQA4w2SNB7X9tmCU5+W0cs6a5SecHwc4O1krlgRjWDQkpk++JkqMD3Fah7hKTL
         W1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695959425; x=1696564225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYYbHmRBUQu7YjfKhJdocL7dPfjriCkGg2JwzJsWdwM=;
        b=T/FAfVimpzOuH5xiQtMx4XdmakF5pDE6yXnUyQ5Jzni/wtsv1x+UhZWlwOFAwakRZA
         gNG75ASI6PPOjKGEyk0dcol2k+bzLJvUy8Bmpu1ZQfukvyCiPWGEsG8Kf3vgHiNGUae6
         YRN3vzgTqOUokJq40iL1dEDV9X5E0d76D0iUg04oCTHie6jaVRRqWSVB2Edw7i+/ZCS3
         NiNdFZy/fXEbbvbhBJiHXpXQtwXAWGQJb1Ji2BTsW46kDFQOacaGIZtWWlbWPQcDEimw
         w9IaZQNlNSGNaJ5T6nKUvz84rmpV7LpH8k6Kt9UyhaHIwYdf3InILodtmBjGVWFC45NG
         zLAg==
X-Gm-Message-State: AOJu0YwgZdCc08cn6CTm/xt2RQjLn1ZWBcDhorLXBB4gj5Jh+KOJlUiC
        uNBYVSW9EubLAuCBTFJndFdf9lkdahI85C13mFk=
X-Google-Smtp-Source: AGHT+IGZ9FbyCI7u8iOe4evpIjYBqumu0LCfPbLB14Vob7h48kUS/cZM9tDSVc21MSgdNbX4O2KSgM/HSLf/cSOdPJI=
X-Received: by 2002:a05:620a:45a8:b0:774:1875:edb1 with SMTP id
 bp40-20020a05620a45a800b007741875edb1mr3147718qkb.20.1695959424913; Thu, 28
 Sep 2023 20:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230928110554.34758-1-jlayton@kernel.org> <20230928110554.34758-2-jlayton@kernel.org>
 <6020d6e7-b187-4abb-bf38-dc09d8bd0f6d@app.fastmail.com> <af047e4a1c6947c59d4a13d4ae221c784a5386b4.camel@kernel.org>
 <20230928171943.GK11439@frogsfrogsfrogs> <6a6f37d16b55a3003af3f3dbb7778a367f68cd8d.camel@kernel.org>
 <20230928212656.GC189345@mit.edu> <CAHk-=wjTynK9BdGbi+8eShU77nkPvipFwRxEd1TSBrw2+LiuDg@mail.gmail.com>
In-Reply-To: <CAHk-=wjTynK9BdGbi+8eShU77nkPvipFwRxEd1TSBrw2+LiuDg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 29 Sep 2023 06:50:13 +0300
Message-ID: <CAOQ4uxg5ctY9yCjLOjN1nETAcEuNb2UERnYuDv7PoErdxX=WUw@mail.gmail.com>
Subject: Re: [PATCH 86/87] fs: switch timespec64 fields in inode to discrete integers
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jeff Layton <jlayton@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        David Sterba <dsterba@suse.cz>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, Jeremy Kerr <jk@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Mattia Dongili <malattia@linux.it>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Brad Warrum <bwarrum@linux.ibm.com>,
        Ritu Agarwal <rituagar@linux.ibm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Ian Kent <raven@themaw.net>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@gl0jj8bn.sched.sma.tdnsstic1.cn>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>, Jan Kara <jack@suse.cz>,
        David Woodhouse <dwmw2@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>, Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Bob Copeland <me@bobcopeland.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Anders Larsen <al@alarsen.net>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        Chandan Babu R <chandan.babu@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, v9fs@lists.linux.dev,
        linux-afs@lists.infradead.org, autofs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@telemann.coda.cs.cmu.edu, linux-efi@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, gfs2@lists.linux.dev,
        linux-um@lists.infradead.org, linux-mtd@lists.infradead.org,
        jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-unionfs@vger.kernel.org, linux-hardening@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org,
        linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        bpf@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 29, 2023 at 3:19=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
...
> So yes, real programs to cache stat information, and it matters for perfo=
rmance.
>
> But I don't think any actual reasonable program will have
> *correctness* issues, though -

I beg to disagree.

> because there are certainly filesystems
> out there that don't do nanosecond resolution (and other operations
> like copying trees around will obviously also change times).
>
> Anybody doing steganography in the timestamps is already not going to
> have a great time, really.
>

Your thesis implies that all applications are portable across different
filesystems and all applications are expected to cope with copying
trees around.

There are applications that work on specific filesystems and those
applications are very much within sanity if they expect that past
observed values of nsec will not to change if the file was not changed.

But even if we agree that will "only" hurt performance, your example of
performance hit (10s of git diff) is nowhere close to the performance
hit of invalidating the mtime cache of billions of files at once (i.e. afte=
r
kernel upgrade), which means that rsync-like programs need to
re-read all the data from remote locations.

I am not saying that filesystems cannot decide to *stop storing nsec
granularity* from this day forth, but like btrfs pre-historic timestamps,
those fs have an obligation to preserve existing metadata, unless
users opted to throw it away.

OTOH, it is perfectly fine if the vfs wants to stop providing sub 100ns
services to filesystems. It's just going to be the fs problem and the
preserved pre-historic/fine-grained time on existing files would only
need to be provided in getattr(). It does not need to be in __i_mtime.

Thanks,
Amir.
