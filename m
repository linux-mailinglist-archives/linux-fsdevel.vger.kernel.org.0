Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A1C7B2667
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 22:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjI1UVo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 16:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjI1UVl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:21:41 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8728219F;
        Thu, 28 Sep 2023 13:21:38 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 10FFD5C010B;
        Thu, 28 Sep 2023 16:21:36 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 28 Sep 2023 16:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695932496; x=1696018896; bh=35
        hGd5DtemMMIKF1Zr0cZ5jy7ToQQid1yaZKtlkxNu4=; b=kYePS9tb7iX4DfdsrP
        KSG5kIGZHZ6II373RLg/R6yievFf5ZYxGwh2bHABIynK2hkA52tpJp3Oqt6Z3WOr
        EqKj++ONhEZxtgYMqLWXCzvXzNYTY67C+FNTS8BO7KmsYa1dEu2LxNvTTGge5dTC
        98J8ERH0LgbaCs96bDreSwTyXJA52oIcXMJdWw5N86IHuBkNDy0oNr/0YRW4bAe/
        0M4666MlVq40oMzm+hOyKlTRfSVgmNV/d/3Ff0cJaJ0SNIaaJnTv2IECtjx7okcZ
        2oTzttml5wZkULDWHm+AqgNYcCGYK4B55B9Z6uwZLoNIrGvBjakjMQdqnYhny59X
        c+DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695932496; x=1696018896; bh=35hGd5DtemMMI
        KF1Zr0cZ5jy7ToQQid1yaZKtlkxNu4=; b=Mi38mWEo6Tol35uWyjeJmmWCT6PhB
        HqHdQW8+/vTI7Qw8Bqjnf4yascDSnQ3TwDDgcbk0sbZbyRT57QkzfpVhTvQ8tyG/
        LToaN9PzpBS9QrAj9YMndKxYandOQbuYzjXUqBNmiENTlTffglDnwu2iuDr2TsU+
        /NNGLhQAXePxiL0pEdoLHMSXcoqi6N/AkRauYrgRvDxZcWexBs/kQpWi1R5l+oVf
        it+YrCNEgaozEQG8vQeVMxdjNU22qXU18zXjjUwBmzzgDSvsRTJJPv6DyBI9Pzys
        O8qdOCiu0Uk7vB8Y73BLyFXAFOIxbyg1bikunx6mKyaqpJQGWudajkQ0A==
X-ME-Sender: <xms:T-AVZXL3VaPyWViVEJgM3yExxV-dwzqvVS-FZAOgHbMjfs78IaNp2A>
    <xme:T-AVZbLj-AjwUM1fYc_IF46JFhXtrQoib8RbARgHo3iYEEvHQtVh1hDhJXxy9TfON
    Oh1HgE-A4WCFJQzSj0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrtddtgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:T-AVZfs2A6qgNC9q-Lgew5QpLTG6DfFGYM3yBsc6aJA3RBohmNNTbA>
    <xmx:T-AVZQZXC-VhrDIz8AYhFJ3sygxqV6IDLpvW50oXyZEvi4CB1UyOSA>
    <xmx:T-AVZeY1z19-8JCLhF1ER_yDksvGyMLWs3MGVsw1t9smfaE7ndMYdw>
    <xmx:UOAVZQYAMlK7auUTlutzfZRoDi91DxEaPpUdggLB7gVAJPc0VTm_bQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 360CCB60089; Thu, 28 Sep 2023 16:21:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <ded0ef74-bdad-42f2-b0a7-5d867e446c19@app.fastmail.com>
In-Reply-To: <6a6f37d16b55a3003af3f3dbb7778a367f68cd8d.camel@kernel.org>
References: <20230928110554.34758-1-jlayton@kernel.org>
 <20230928110554.34758-2-jlayton@kernel.org>
 <6020d6e7-b187-4abb-bf38-dc09d8bd0f6d@app.fastmail.com>
 <af047e4a1c6947c59d4a13d4ae221c784a5386b4.camel@kernel.org>
 <20230928171943.GK11439@frogsfrogsfrogs>
 <6a6f37d16b55a3003af3f3dbb7778a367f68cd8d.camel@kernel.org>
Date:   Thu, 28 Sep 2023 16:21:12 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jeff Layton" <jlayton@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Christian Brauner" <brauner@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "David Sterba" <dsterba@suse.cz>,
        "Amir Goldstein" <amir73il@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Kees Cook" <keescook@chromium.org>, "Jeremy Kerr" <jk@ozlabs.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        "Vasily Gorbik" <gor@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        "Sven Schnelle" <svens@linux.ibm.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        "Todd Kjos" <tkjos@android.com>,
        "Martijn Coenen" <maco@android.com>,
        "Joel Fernandes" <joel@joelfernandes.org>,
        "Carlos Llamas" <cmllamas@google.com>,
        "Suren Baghdasaryan" <surenb@google.com>,
        "Mattia Dongili" <malattia@linux.it>,
        "Dennis Dalessandro" <dennis.dalessandro@cornelisnetworks.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Leon Romanovsky" <leon@kernel.org>,
        "Brad Warrum" <bwarrum@linux.ibm.com>,
        "Ritu Agarwal" <rituagar@linux.ibm.com>,
        "Hans de Goede" <hdegoede@redhat.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Mark Gross" <markgross@kernel.org>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        "Eric Van Hensbergen" <ericvh@kernel.org>,
        "Latchesar Ionkov" <lucho@ionkov.net>,
        "Dominique Martinet" <asmadeus@codewreck.org>,
        "Christian Schoenebeck" <linux_oss@crudebyte.com>,
        "David Sterba" <dsterba@suse.com>,
        "David Howells" <dhowells@redhat.com>,
        "Marc Dionne" <marc.dionne@auristor.com>,
        "Ian Kent" <raven@themaw.net>,
        "Luis de Bethencourt" <luisbg@kernel.org>,
        "Salah Triki" <salah.triki@gmail.com>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        "Chris Mason" <clm@fb.com>, "Josef Bacik" <josef@toxicpanda.com>,
        "Xiubo Li" <xiubli@redhat.com>,
        "Ilya Dryomov" <idryomov@gmail.com>,
        "Jan Harkes" <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        "Joel Becker" <jlbec@evilplan.org>,
        "Christoph Hellwig" <hch@lst.de>,
        "Nicolas Pitre" <nico@fluxnic.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Ard Biesheuvel" <ardb@kernel.org>, "Gao Xiang" <xiang@kernel.org>,
        "Chao Yu" <chao@kernel.org>, "Yue Hu" <huyue2@coolpad.com>,
        "Jeffle Xu" <jefflexu@linux.alibaba.com>,
        "Namjae Jeon" <linkinjeon@kernel.org>,
        "Sungjong Seo" <sj1557.seo@samsung.com>,
        "Jan Kara" <jack@suse.com>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>,
        "Jaegeuk Kim" <jaegeuk@kernel.org>,
        "OGAWA Hirofumi" <hirofumi@mail.parknet.co.jp>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Miklos Szeredi" <miklos@szeredi.hu>,
        "Bob Peterson" <rpeterso@redhat.com>,
        "Andreas Gruenbacher" <agruenba@redhat.com>,
        "Richard Weinberger" <richard@nod.at>,
        "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
        "Johannes Berg" <johannes@sipsolutions.net>,
        "Mikulas Patocka" <mikulas@artax.karlin.mff.cuni.cz>,
        "Mike Kravetz" <mike.kravetz@oracle.com>,
        "Muchun Song" <muchun.song@linux.dev>, "Jan Kara" <jack@suse.cz>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Dave Kleikamp" <shaggy@kernel.org>, "Tejun Heo" <tj@kernel.org>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna@kernel.org>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Neil Brown" <neilb@suse.de>,
        "Olga Kornievskaia" <kolga@netapp.com>,
        "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
        "Ryusuke Konishi" <konishi.ryusuke@gmail.com>,
        "Anton Altaparmakov" <anton@tuxera.com>,
        "Konstantin Komarov" <almaz.alexandrovich@paragon-software.com>,
        "Mark Fasheh" <mark@fasheh.com>,
        "Joseph Qi" <joseph.qi@linux.alibaba.com>,
        "Bob Copeland" <me@bobcopeland.com>,
        "Mike Marshall" <hubcap@omnibond.com>,
        "Martin Brandenburg" <martin@omnibond.com>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        "Iurii Zaikin" <yzaikin@google.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Anders Larsen" <al@alarsen.net>,
        "Steve French" <sfrench@samba.org>,
        "Paulo Alcantara" <pc@manguebit.com>,
        "Ronnie Sahlberg" <lsahlber@redhat.com>,
        "Shyam Prasad N" <sprasad@microsoft.com>,
        "Sergey Senozhatsky" <senozhatsky@chromium.org>,
        "Phillip Lougher" <phillip@squashfs.org.uk>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Evgeniy Dushistov" <dushistov@mail.ru>,
        "Chandan Babu R" <chandan.babu@oracle.com>,
        "Damien Le Moal" <dlemoal@kernel.org>,
        "Naohiro Aota" <naohiro.aota@wdc.com>,
        "Johannes Thumshirn" <jth@kernel.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "Andrii Nakryiko" <andrii@kernel.org>,
        "Martin KaFai Lau" <martin.lau@linux.dev>,
        "Song Liu" <song@kernel.org>,
        "Yonghong Song" <yonghong.song@linux.dev>,
        "John Fastabend" <john.fastabend@gmail.com>,
        "KP Singh" <kpsingh@kernel.org>,
        "Stanislav Fomichev" <sdf@google.com>,
        "Hao Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>,
        "Hugh Dickins" <hughd@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "John Johansen" <john.johansen@canonical.com>,
        "Paul Moore" <paul@paul-moore.com>,
        "James Morris" <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Stephen Smalley" <stephen.smalley.work@gmail.com>,
        "Eric Paris" <eparis@parisplace.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, v9fs@lists.linux.dev,
        linux-afs@lists.infradead.org, autofs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, linux-efi@vger.kernel.org,
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
Subject: Re: [PATCH 86/87] fs: switch timespec64 fields in inode to discrete integers
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 28, 2023, at 13:40, Jeff Layton wrote:
> On Thu, 2023-09-28 at 10:19 -0700, Darrick J. Wong wrote:
>>
>> > I remember seeing those patches go by. I don't remember that change
>> > being NaK'ed, but I wasn't paying close attention at the time 
>> > 
>> > Looking at it objectively now, I think it's worth it to recover 8 bytes
>> > per inode and open a 4 byte hole that Amir can use to grow the
>> > i_fsnotify_mask. We might even able to shave off another 12 bytes
>> > eventually if we can move to a single 64-bit word per timestamp. 
>> 
>> I don't think you can, since btrfs timestamps utilize s64 seconds
>> counting in both directions from the Unix epoch.  They also support ns
>> resolution:
>> 
>> 	struct btrfs_timespec {
>> 		__le64 sec;
>> 		__le32 nsec;
>> 	} __attribute__ ((__packed__));
>> 
>
> Correct. We'd lose some fidelity in currently stored timestamps, but as
> Linus and Ted pointed out, anything below ~100ns granularity is
> effectively just noise, as that's the floor overhead for calling into
> the kernel. It's hard to argue that any application needs that sort of
> timestamp resolution, at least with contemporary hardware. 

There are probably applications that have come up with creative
ways to use the timestamp fields of file systems that 94 bits
of data, with both the MSB of the seconds and the LSB of the
nanoseconds carrying information that they expect to be preserved.

Dropping any information in the nanoseconds other than the top two
bits would trivially change the 'ls -t' output when two files have
the same timestamp in one kernel but slightly different timestamps
in another one. For large values of 'tv_sec', there are fewer
obvious things that break, but if current kernels are able to
retrieve arbitrary times that were stored with utimensat(), then we
should probably make sure future kernels can see the same.

        Arnd
