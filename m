Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01B674A32D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 19:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjGFRiX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 13:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGFRiW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:38:22 -0400
X-Greylist: delayed 2136 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Jul 2023 10:38:08 PDT
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8382310C;
        Thu,  6 Jul 2023 10:38:08 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:40568)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qHQio-00FMgf-7e; Thu, 06 Jul 2023 09:16:42 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:55228 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qHQim-00AsXt-Fk; Thu, 06 Jul 2023 09:16:41 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     jk@ozlabs.org, arnd@arndb.de, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
        cmllamas@google.com, surenb@google.com,
        dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        leon@kernel.org, bwarrum@linux.ibm.com, rituagar@linux.ibm.com,
        ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
        linux_oss@crudebyte.com, dsterba@suse.com, dhowells@redhat.com,
        marc.dionne@auristor.com, viro@zeniv.linux.org.uk,
        raven@themaw.net, luisbg@kernel.org, salah.triki@gmail.com,
        aivazian.tigran@gmail.com, keescook@chromium.org, clm@fb.com,
        josef@toxicpanda.com, xiubli@redhat.com, idryomov@gmail.com,
        jaharkes@cs.cmu.edu, coda@cs.cmu.edu, jlbec@evilplan.org,
        hch@lst.de, nico@fluxnic.net, rafael@kernel.org, code@tyhicks.com,
        ardb@kernel.org, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        linkinjeon@kernel.org, sj1557.seo@samsung.com, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        hirofumi@mail.parknet.co.jp, miklos@szeredi.hu,
        rpeterso@redhat.com, agruenba@redhat.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        mikulas@artax.karlin.mff.cuni.cz, mike.kravetz@oracle.com,
        muchun.song@linux.dev, dwmw2@infradead.org, shaggy@kernel.org,
        tj@kernel.org, trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com, konishi.ryusuke@gmail.com,
        anton@tuxera.com, almaz.alexandrovich@paragon-software.com,
        mark@fasheh.com, joseph.qi@linux.alibaba.com, me@bobcopeland.com,
        hubcap@omnibond.com, martin@omnibond.com, amir73il@gmail.com,
        mcgrof@kernel.org, yzaikin@google.com, tony.luck@intel.com,
        gpiccoli@igalia.com, al@alarsen.net, sfrench@samba.org,
        pc@manguebit.com, lsahlber@redhat.com, sprasad@microsoft.com,
        senozhatsky@chromium.org, phillip@squashfs.org.uk,
        rostedt@goodmis.org, mhiramat@kernel.org, dushistov@mail.ru,
        hdegoede@redhat.com, djwong@kernel.org, dlemoal@kernel.org,
        naohiro.aota@wdc.com, jth@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, hughd@google.com, akpm@linux-foundation.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, john.johansen@canonical.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        jgross@suse.com, stern@rowland.harvard.edu, lrh2000@pku.edu.cn,
        sebastian.reichel@collabora.com, wsa+renesas@sang-engineering.com,
        quic_ugoswami@quicinc.com, quic_linyyuan@quicinc.com,
        john@keeping.me.uk, error27@gmail.com, quic_uaggarwa@quicinc.com,
        hayama@lineo.co.jp, jomajm@gmail.com, axboe@kernel.dk,
        dhavale@google.com, dchinner@redhat.com, hannes@cmpxchg.org,
        zhangpeng362@huawei.com, slava@dubeyko.com, gargaditya08@live.com,
        penguin-kernel@I-love.SAKURA.ne.jp, yifeliu@cs.stonybrook.edu,
        madkar@cs.stonybrook.edu, ezk@cs.stonybrook.edu,
        yuzhe@nfschina.com, willy@infradead.org, okanatov@gmail.com,
        jeffxu@chromium.org, linux@treblig.org, mirimmad17@gmail.com,
        yijiangshan@kylinos.cn, yang.yang29@zte.com.cn,
        xu.xin16@zte.com.cn, chengzhihao1@huawei.com, shr@devkernel.io,
        Liam.Howlett@Oracle.com, adobriyan@gmail.com,
        chi.minghao@zte.com.cn, roberto.sassu@huawei.com,
        linuszeng@tencent.com, bvanassche@acm.org, zohar@linux.ibm.com,
        yi.zhang@huawei.com, trix@redhat.com, fmdefrancesco@gmail.com,
        ebiggers@google.com, princekumarmaurya06@gmail.com,
        chenzhongjin@huawei.com, riel@surriel.com,
        shaozhengchao@huawei.com, jingyuwang_vip@163.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-usb@vger.kernel.org, v9fs@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        autofs@vger.kernel.org, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-um@lists.infradead.org,
        linux-mtd@lists.infradead.org,
        jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-unionfs@vger.kernel.org, linux-hardening@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org,
        linux-trace-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
References: <20230705185812.579118-1-jlayton@kernel.org>
        <a4e6cfec345487fc9ac8ab814a817c79a61b123a.camel@kernel.org>
Date:   Thu, 06 Jul 2023 10:16:19 -0500
In-Reply-To: <a4e6cfec345487fc9ac8ab814a817c79a61b123a.camel@kernel.org> (Jeff
        Layton's message of "Wed, 05 Jul 2023 17:57:46 -0400")
Message-ID: <87ilaxgjek.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qHQim-00AsXt-Fk;;;mid=<87ilaxgjek.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19hfnilZzLMqG1RlF+DuMto1+nqSkCNAbk=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Jeff Layton <jlayton@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 959 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (1.2%), b_tie_ro: 10 (1.1%), parse: 1.62
        (0.2%), extract_message_metadata: 4.3 (0.4%), get_uri_detail_list:
        1.88 (0.2%), tests_pri_-2000: 2.4 (0.3%), tests_pri_-1000: 10 (1.1%),
        tests_pri_-950: 1.27 (0.1%), tests_pri_-900: 1.56 (0.2%),
        tests_pri_-200: 0.85 (0.1%), tests_pri_-100: 4.3 (0.4%),
        tests_pri_-90: 283 (29.5%), check_bayes: 278 (29.0%), b_tokenize: 27
        (2.9%), b_tok_get_all: 20 (2.1%), b_comp_prob: 4.6 (0.5%),
        b_tok_touch_all: 220 (23.0%), b_finish: 0.94 (0.1%), tests_pri_0: 616
        (64.3%), check_dkim_signature: 0.56 (0.1%), check_dkim_adsp: 2.8
        (0.3%), poll_dns_idle: 0.55 (0.1%), tests_pri_10: 2.2 (0.2%),
        tests_pri_500: 9 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 00/89] fs: new accessors for inode->i_ctime
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> writes:

> On Wed, 2023-07-05 at 14:58 -0400, Jeff Layton wrote:
>> v2:
>> - prepend patches to add missing ctime updates
>> - add simple_rename_timestamp helper function
>> - rename ctime accessor functions as inode_get_ctime/inode_set_ctime_*
>> - drop individual inode_ctime_set_{sec,nsec} helpers
>> 
>> I've been working on a patchset to change how the inode->i_ctime is
>> accessed in order to give us conditional, high-res timestamps for the
>> ctime and mtime. struct timespec64 has unused bits in it that we can use
>> to implement this. In order to do that however, we need to wrap all
>> accesses of inode->i_ctime to ensure that bits used as flags are
>> appropriately handled.
>> 
>> The patchset starts with reposts of some missing ctime updates that I
>> spotted in the tree. It then adds a new helper function for updating the
>> timestamp after a successful rename, and new ctime accessor
>> infrastructure.
>> 
>> The bulk of the patchset is individual conversions of different
>> subsysteme to use the new infrastructure. Finally, the patchset renames
>> the i_ctime field to __i_ctime to help ensure that I didn't miss
>> anything.
>> 
>> This should apply cleanly to linux-next as of this morning.
>> 
>> Most of this conversion was done via 5 different coccinelle scripts, run
>> in succession, with a large swath of by-hand conversions to clean up the
>> remainder.
>> 
>
> A couple of other things I should note:
>
> If you sent me an Acked-by or Reviewed-by in the previous set, then I
> tried to keep it on the patch here, since the respun patches are mostly
> just renaming stuff from v1. Let me know if I've missed any.
>
> I've also pushed the pile to my tree as this tag:
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/tag/?h=ctime.20230705
>
> In case that's easier to work with.

Are there any preliminary patches showing what you want your introduced
accessors to turn into?  It is hard to judge the sanity of the
introduction of wrappers without seeing what the wrappers are ultimately
going to do.

Eric
