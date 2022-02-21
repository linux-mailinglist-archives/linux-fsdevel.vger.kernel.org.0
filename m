Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9734BD739
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 08:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345743AbiBUHAA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 02:00:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238938AbiBUG77 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 01:59:59 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7529BBA9;
        Sun, 20 Feb 2022 22:59:36 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21L4BB4l002788;
        Mon, 21 Feb 2022 06:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ay2Z2KBRA8mpX5XVJ8Q99l/i+tEFD+FUQgOGgEZjFI0=;
 b=r9pqLqw0JMretylDT4lvIZvkH4JgsPemn9JDhUro1xW9QSHy1Nj/+Up3fJHkcr5WLvAE
 HCRGyepg3ASYhxNMswsKpVuG1Ba43CEDZuoz9rNAtvsIppjYBVPkaicD35vTZ/vFG95v
 G5l0gJjFpWMNtqy8Oi9MlKvZdZdMWCOpFOa1PoC1VrSSi2q6XrdFIlBWuWVwkETAE0Un
 nRpGa+eKYPIV1oQkZQC59/0la6YBMlbJ5AY1aolLNnmt46dloaaZeoarGd3+7cOA2yOO
 /1TuKiqXM1aRIaoRgv0qHSfT340YF++wS+16OXf0I2nKM6gr6E7C1qZObHQdhY9ZxmTf 2A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ebxrhppg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 06:59:30 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21L6uLqx012639;
        Mon, 21 Feb 2022 06:59:29 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ebxrhppfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 06:59:29 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21L6wg0Z009389;
        Mon, 21 Feb 2022 06:59:27 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3ear68r503-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 06:59:26 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21L6xOgr51642628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 06:59:24 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A76C84C040;
        Mon, 21 Feb 2022 06:59:24 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3798D4C044;
        Mon, 21 Feb 2022 06:59:24 +0000 (GMT)
Received: from localhost (unknown [9.43.127.119])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 21 Feb 2022 06:59:23 +0000 (GMT)
Date:   Mon, 21 Feb 2022 12:29:22 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/1] ext4: Improve fast_commit performance and scalability
Message-ID: <20220221065922.7h62uofay2frugfs@riteshh-domain>
References: <cover.1644809996.git.riteshh@linux.ibm.com>
 <a2dcc8dbedfd221b90ff02cdb0dfb3c6a7ef2ae9.1644809996.git.riteshh@linux.ibm.com>
 <CAD+ocbzzUXJ7qk7Yx2NGuXVKOAKv0yyxo+95o5+6krcAsGmOpA@mail.gmail.com>
 <20220217155749.fyknvedbhmfqbir2@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217155749.fyknvedbhmfqbir2@riteshh-domain>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aCHvQeIfcmlNpZM03l9PXf4qHvGqoC5O
X-Proofpoint-GUID: p-q9LdEgixFvdxY8b2e71Y65xu8aeKoX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-21_02,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 impostorscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 phishscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202210041
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Harshad,

Few points below.

On 22/02/17 09:27PM, Ritesh Harjani wrote:
> On 22/02/16 03:25PM, harshad shirwadkar wrote:
> > Thanks for the patch Ritesh. Some questions / comments inlined:
>
> Thanks a lot for reviewing this :)
>
> >
> > On Sun, 13 Feb 2022 at 19:57, Ritesh Harjani <riteshh@linux.ibm.com> wrote:
> > >
> > > Currently ext4_fc_commit_dentry_updates() is of quadratic time
> > > complexity, which is causing performance bottlenecks with high
> > > threads/file/dir count with fs_mark.
> > >
> > > This patch makes commit dentry updates (and hence ext4_fc_commit()) path
> > > to linear time complexity. Hence improves the performance of workloads
> > > which does fsync on multiple threads/open files one-by-one.
> > >
> > > Absolute numbers in avg file creates per sec (from fs_mark in 1K order)
> > > =======================================================================
> > > no.     Order   without-patch(K)   with-patch(K)   Diff(%)
> > > 1       1        16.90              17.51           +3.60
> > > 2       2,2      32.08              31.80           -0.87
> > > 3       3,3      53.97              55.01           +1.92
> > > 4       4,4      78.94              76.90           -2.58
> > > 5       5,5      95.82              95.37           -0.46
> > > 6       6,6      87.92              103.38          +17.58
> > > 7       6,10      0.73              126.13          +17178.08
> > > 8       6,14      2.33              143.19          +6045.49
> > >
> > > workload type
> > > ==============
> > > For e.g. 7th row order of 6,10 (2^6 == 64 && 2^10 == 1024)
> > > echo /run/riteshh/mnt/{1..64} |sed -E 's/[[:space:]]+/ -d /g' \
> > >   | xargs -I {} bash -c "sudo fs_mark -L 100 -D 1024 -n 1024 -s0 -S5 -d {}"
> > >
> > > Perf profile
> > > (w/o patches)
> > > =============================
> > > 87.15%  [kernel]  [k] ext4_fc_commit           --> Heavy contention/bottleneck
> > >  1.98%  [kernel]  [k] perf_event_interrupt
> > >  0.96%  [kernel]  [k] power_pmu_enable
> > >  0.91%  [kernel]  [k] update_sd_lb_stats.constprop.0
> > >  0.67%  [kernel]  [k] ktime_get
> > >
> > > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > > ---
> > >  fs/ext4/ext4.h        |  2 ++
> > >  fs/ext4/fast_commit.c | 64 +++++++++++++++++++++++++++++++------------
> > >  fs/ext4/fast_commit.h |  1 +
> > >  3 files changed, 50 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > > index bcd3b9bf8069..25242648d8c9 100644
> > > --- a/fs/ext4/ext4.h
> > > +++ b/fs/ext4/ext4.h
> > > @@ -1046,6 +1046,8 @@ struct ext4_inode_info {
> > >
> > >         /* Fast commit related info */
> > >
> > > +       /* For tracking dentry create updates */
> > > +       struct list_head i_fc_dilist;
> > The only case in which this list will have multiple entries if hard
> > links are created on this inode right? I think that's probably a very
>
> So I too had this thought on my mind later. But then I ended up coding the old way
> only.
>
> Ok, so it seems it is only when the first time an inode is created we
> will have a EXT4_FC_TAG_CREAT. When we are creating a hard link that's actually
> a EXT4_FC_TAG_LINK.
> So I think there shouldn't be any case where we have more than one fc_dentry for
> the same inode. Your thoughts?
>
>
> > rare scenario and we can just fallback to full commits. That might
> > simplify this patch a bit. Basically if you do that then fc_dentry
> > would directly store a pointer to the inode and the inode can store a
> > pointer to the "CREAT" fc_dentry object. That way we don't have to do
> > list traversals in fc_del and fc_commit. But barring a few fixes, what
> > you have here is fine too. So I'll leave it up to you to decide what
> > you want to do.
>
> Yes, you are right. If there is only a single fc_dentry object for any given
> inode, then we can store back pointers in each of those to point to their
> respective inode and fc_dentry objects.
>
> I will try and change this in next revision then.

I tried this approach. But it soon becomes messy the moment we think of adding
a inode pointer in fc_dentry object. Once that happens, we also want to
remove fcd_ino, since we have a inode and then we need to take care of a lot of
corner cases where inode will be lost since we don't hold any references.

whereas,

If we still use the struct list_head abstraction then we don't have to add a lot
of careful if else checking and things are much clear to understand.

What I would like to do now is send out a v2 addressing your review comments.
So I am not doing any list traversal now, but just popping the list first entry
and adding a warn_on if list does not becomes empty.

Could you then please take a look at v2 and suggest if you are fine with the
patch/design. We can take it from there then.

-ritesh

>
> > >         struct list_head i_fc_list;     /*
> > >                                          * inodes that need fast commit
> > >                                          * protected by sbi->s_fc_lock.
> > > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > > index 7964ee34e322..f2bee4cf5648 100644
> > > --- a/fs/ext4/fast_commit.c
> > > +++ b/fs/ext4/fast_commit.c
> > > @@ -199,6 +199,7 @@ void ext4_fc_init_inode(struct inode *inode)
> > >         ext4_fc_reset_inode(inode);
> > >         ext4_clear_inode_state(inode, EXT4_STATE_FC_COMMITTING);
> > >         INIT_LIST_HEAD(&ei->i_fc_list);
> > > +       INIT_LIST_HEAD(&ei->i_fc_dilist);
> > >         init_waitqueue_head(&ei->i_fc_wait);
> > >         atomic_set(&ei->i_fc_updates, 0);
> > >  }
> > > @@ -279,6 +280,8 @@ void ext4_fc_stop_update(struct inode *inode)
> > >  void ext4_fc_del(struct inode *inode)
> > >  {
> > >         struct ext4_inode_info *ei = EXT4_I(inode);
> > > +       struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> > > +       struct ext4_fc_dentry_update *fc_dentry, *fc_dentry_n;
> > >
> > >         if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
> > >             (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
> > > @@ -286,7 +289,7 @@ void ext4_fc_del(struct inode *inode)
> > >
> > >  restart:
> > >         spin_lock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> > > -       if (list_empty(&ei->i_fc_list)) {
> > > +       if (list_empty(&ei->i_fc_list) && list_empty(&ei->i_fc_dilist)) {
> > >                 spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> > >                 return;
> > >         }
> > > @@ -295,7 +298,26 @@ void ext4_fc_del(struct inode *inode)
> > >                 ext4_fc_wait_committing_inode(inode);
> > >                 goto restart;
> > >         }
> > > -       list_del_init(&ei->i_fc_list);
> > > +
> > > +       if (!list_empty(&ei->i_fc_list))
> > > +               list_del_init(&ei->i_fc_list);
> > > +
> > > +       /*
> > > +        * Since this inode is getting removed, let's also remove all FC
> > > +        * dentry create references, since it is not needed to log it anyways.
> > > +        */
> > > +       list_for_each_entry_safe(fc_dentry, fc_dentry_n, &ei->i_fc_dilist, fcd_dilist) {
> > > +               WARN_ON(fc_dentry->fcd_op != EXT4_FC_TAG_CREAT);
> > > +               list_del_init(&fc_dentry->fcd_list);
> > > +               list_del_init(&fc_dentry->fcd_dilist);
> > > +               spin_unlock(&sbi->s_fc_lock);
> > > +
> > > +               if (fc_dentry->fcd_name.name &&
> > > +                       fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
> > > +                       kfree(fc_dentry->fcd_name.name);
> > > +               kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
> > > +               return;
> > Shouldn't we continue and remove all nodes in ei->i_fc_dilist?
>
> Yes, I guess this survived, since we anyway have only one entry in the list
> always. But thanks for catching.
>
> > > +       }
> > >         spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> > >  }
> > >
> > > @@ -427,7 +449,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
> > >                 node->fcd_name.name = node->fcd_iname;
> > >         }
> > >         node->fcd_name.len = dentry->d_name.len;
> > > -
> > > +       INIT_LIST_HEAD(&node->fcd_dilist);
> > >         spin_lock(&sbi->s_fc_lock);
> > >         if (sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
> > >                 sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING)
> > > @@ -435,6 +457,18 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
> > >                                 &sbi->s_fc_dentry_q[FC_Q_STAGING]);
> > >         else
> > >                 list_add_tail(&node->fcd_list, &sbi->s_fc_dentry_q[FC_Q_MAIN]);
> > > +
> > > +       /*
> > > +        * This helps us keep a track of all fc_dentry updates which is part of
> > > +        * this ext4 inode. So in case the inode is getting unlinked, before
> > > +        * even we get a chance to fsync, we could remove all fc_dentry
> > > +        * references while evicting the inode in ext4_fc_del().
> > > +        * Also with this, we don't need to loop over all the inodes in
> > > +        * sbi->s_fc_q to get the corresponding inode in
> > > +        * ext4_fc_commit_dentry_updates().
> > > +        */
> > > +       if (dentry_update->op == EXT4_FC_TAG_CREAT)
> > > +               list_add_tail(&node->fcd_dilist, &ei->i_fc_dilist);
> > >         spin_unlock(&sbi->s_fc_lock);
> > >         mutex_lock(&ei->i_fc_lock);
> > >
> > > @@ -954,7 +988,7 @@ __releases(&sbi->s_fc_lock)
> > >         struct ext4_sb_info *sbi = EXT4_SB(sb);
> > >         struct ext4_fc_dentry_update *fc_dentry, *fc_dentry_n;
> > >         struct inode *inode;
> > > -       struct ext4_inode_info *ei, *ei_n;
> > > +       struct ext4_inode_info *ei;
> > >         int ret;
> > >
> > >         if (list_empty(&sbi->s_fc_dentry_q[FC_Q_MAIN]))
> > > @@ -970,21 +1004,16 @@ __releases(&sbi->s_fc_lock)
> > >                         spin_lock(&sbi->s_fc_lock);
> > >                         continue;
> > >                 }
> > > -
> > > -               inode = NULL;
> > > -               list_for_each_entry_safe(ei, ei_n, &sbi->s_fc_q[FC_Q_MAIN],
> > > -                                        i_fc_list) {
> > > -                       if (ei->vfs_inode.i_ino == fc_dentry->fcd_ino) {
> > > -                               inode = &ei->vfs_inode;
> > > -                               break;
> > > -                       }
> > > -               }
> > >                 /*
> > > -                * If we don't find inode in our list, then it was deleted,
> > > -                * in which case, we don't need to record it's create tag.
> > > +                * With fcd_dilist we need not loop in sbi->s_fc_q to get the
> > > +                * corresponding inode pointer
> > >                  */
> > > -               if (!inode)
> > > -                       continue;
> > > +               WARN_ON(list_empty(&fc_dentry->fcd_dilist));
> > > +               ei = list_entry(fc_dentry->fcd_dilist.next,
> > > +                               struct ext4_inode_info, i_fc_dilist);
> > I think we want "fc_dentry->fcd_ilist.prev" here right? We are
> > sequentially traversing all the nodes in the list from first to last.
> > Given that I think the inode is the prev of any node that you
> > encounter in the list.
>
> Not that this will be relevant in the next iteration. But doesn't matter right,
> next and prev both will have pointer to inode (since it is a circular doubly
> linked list)? And we are talking about fcd_dilist right?
>
> -ritesh
>
> >
> > - Harshad
> > > +               inode = &ei->vfs_inode;
> > > +               WARN_ON(inode->i_ino != fc_dentry->fcd_ino);
> > > +
> > >                 spin_unlock(&sbi->s_fc_lock);
> > >
> > >                 /*
> > > @@ -1228,6 +1257,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
> > >                                              struct ext4_fc_dentry_update,
> > >                                              fcd_list);
> > >                 list_del_init(&fc_dentry->fcd_list);
> > > +               list_del_init(&fc_dentry->fcd_dilist);
> > >                 spin_unlock(&sbi->s_fc_lock);
> > >
> > >                 if (fc_dentry->fcd_name.name &&
> > > diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
> > > index 083ad1cb705a..02afa52e8e41 100644
> > > --- a/fs/ext4/fast_commit.h
> > > +++ b/fs/ext4/fast_commit.h
> > > @@ -109,6 +109,7 @@ struct ext4_fc_dentry_update {
> > >         struct qstr fcd_name;   /* Dirent name */
> > >         unsigned char fcd_iname[DNAME_INLINE_LEN];      /* Dirent name string */
> > >         struct list_head fcd_list;
> > > +       struct list_head fcd_dilist;
> > >  };
> > >
> > >  struct ext4_fc_stats {
> > > --
> > > 2.31.1
> > >
