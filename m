Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64DECA6A95
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 15:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfICN6b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 09:58:31 -0400
Received: from sonic317-20.consmr.mail.gq1.yahoo.com ([98.137.66.146]:45820
        "EHLO sonic317-20.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729036AbfICN6b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1567519109; bh=NsuQ+R6NXXz4odZ1/3aWCJrvcVThYyrfRW5AC2fBz94=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=DKiMcL5tbcJiCm9F7vfXABYUkzEP4uN0v1nXEh6+IfSAmuvnn8InWmzF4TzjTOaK/9xpDQJ5S9OzQyZiNYIPHwUusQg6UQXsX9yTv4dnyX2vXMIbCuyh+6Vv7dIHUoH8lDFbjBJCrnV8/+WIJGAAAIxb6fOvg92Q1EkWbDs9c2/o+Fp3LfOjG/K9BQDLPMfqdd56woZzZcmReq0SG0jSk5PYDV4yvMzxFizO3M8yP/viPhrOHuS1mfRfVD/zKwZInR9ykzoqS33hJIg02F1U2utXjkDdnrZ85jIXUVfOeei1FChOFdjd8LfRMVEwLIYQU56ETI1Wy5KFYzKSQFV9GA==
X-YMail-OSG: KJPzabwVM1nEZZOrdTNsMS_eVz0I5jW_l6LD0Dz9WEsYEzMABbEygr7gu877RSf
 sFLbYqalSrGOxyWwSif9mdFYjLgwSo44SqJh0XUU0JXjZMuzx0IQ5MWWCxzblIwkNd3D72lCHnLq
 k_LyCbcsZV6G9IZhlbWUCQ2BCrXcjHaddzMNrLDCyryt.PqEq3krqSxfOz4vh_MjJQkuOK2cEM0R
 7lrlGhUd2j.lRKN.pezRwJE0Unv4uM5J8RAe0oPleOqPb6n6ilFJrQZn0beKDWb05RxipNZ6kZ2l
 4uLx.9qU0YFhrcfBrT8GS.FOTGcOIUyqZKxwfT2p_BA03F9gW_yOCrlYsQA.fkhwu3FF2WCzd4gF
 UniC8GVQreuVLVDRv4cZP49SfHNBwL2OSUOTU.VT8j9Va6jw.oVKSiUT4YFghN4iqo3VJeeLhDVq
 m_Pgk8AOgXMOj35wHEGqI.8lvOFrmL8oCa9..1CT8Ia9CW4hszA_Juniv0jX.JRlWtUZCW8gen7q
 nJeCXEEwxt0.aV1Xa4CoC4VLO7hLiGjImQvKxzteR6pgPLhAZM.7xlsqqqUxTUA1xtQqhmN6cImN
 sVwHXUvDNKVdlnbMRUCDrGtzXG6uo3wGl9swSvfCiHvB.ts9UJ.Y1OYbB_MhScJO.dRIJY82Jl1L
 kx2HVj2R31Dt7yFBswp8vOpM8_ESX73w3wWm7q9L9E_tfD1SjmfmEvsI4NpJDB70HBEpfK4YyTZP
 eihcF_HuJcD7eRXPoxOc7FD0cEA062xT_5pllgfhiXPBVulmQH7UKfOEaeQwnL0wePCxbGaSItpA
 w4NG6NK3CORaGOkGtSpgJfJOBXcGbgwsb4TbjmfCnQ1.1zhxH9TfRWu8d3Fs2DcmmMpuFZ9Z1EFk
 AdmLkUShti3GDMn05jqNlVN43uZyb6K83F0ml.z99KTdqVHsaIrmywuCODJ33c8sVf3o6WQVef2q
 7yiGxvAwcDBoqBBn7ZNTjuNW1A5e8eBX9FZNyF6o2cX5LfpsG9QYCqfJ3PmucIEiKJy74Bdm81MO
 4HLPSJacu2o.fmVv0RYn9OvHTZRV7kwz437Q.paPvsAYNXwfqgSRB2Okgdz3xlT3c3cUWgr8gFj9
 lXIWUbkyqKdpZs8nJzgQUHOXm39DibHzRPj4igR8OG6De6iU0zodhH8yomxltwfdHkRvVm1LvduH
 YWu_RezJSy_7Obj8DQeNg4CsvFamrFZRjlUoF15Aga1YEG7N43AvLA9b0vZqsCVIAPYhNuTvY2aI
 YVP36qM8.8f9osMol_9ivP3w-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Tue, 3 Sep 2019 13:58:29 +0000
Received: by smtp424.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c081412583008f12a6be103275c0a77a;
          Tue, 03 Sep 2019 13:58:24 +0000 (UTC)
Date:   Tue, 3 Sep 2019 21:58:15 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, aneesh.kumar@linux.ibm.com,
        Jeff Layton <jlayton@kernel.org>, wugyuan@cn.ibm.com
Subject: Re: [RFC] - vfs: Null pointer dereference issue with symlink create
 and read of symlink
Message-ID: <20190903135803.GA25692@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190903115827.0A8A0A405B@b06wcsmtp001.portsmouth.uk.ibm.com>
 <20190903125946.GA11069@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190903134129.EC5E6A405B@b06wcsmtp001.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903134129.EC5E6A405B@b06wcsmtp001.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 07:11:28PM +0530, Ritesh Harjani wrote:
> 
> 
> On 9/3/19 6:29 PM, Gao Xiang wrote:
> > On Tue, Sep 03, 2019 at 05:28:26PM +0530, Ritesh Harjani wrote:
> > > Hi Viro/All,
> > > 
> > > Could you please review below issue and it's proposed solutions.
> > > If you could let me know which of the two you think will be a better
> > > approach to solve this or in case if you have any other better approach, I
> > > can prepare and submit a official patch with that.
> > > 
> > > 
> > > 
> > > Issue signature:-
> > >   [NIP  : trailing_symlink+80]
> > >   [LR   : trailing_symlink+1092]
> > >   #4 [c00000198069bb70] trailing_symlink at c0000000004bae60  (unreliable)
> > >   #5 [c00000198069bc00] path_openat at c0000000004bdd14
> > >   #6 [c00000198069bc90] do_filp_open at c0000000004c0274
> > >   #7 [c00000198069bdb0] do_sys_open at c00000000049b248
> > >   #8 [c00000198069be30] system_call at c00000000000b388
> > > 
> > > 
> > > 
> > > Test case:-
> > > shell-1 - "while [ 1 ]; do cat /gpfs/g1/testdir/file3; sleep 1; done"
> > > shell-2 - "while [ 1 ]; do ln -s /gpfs/g1/testdir/file1
> > > /gpfs/g1/testdir/file3; sleep 1; rm /gpfs/g1/testdir/file3 sleep 1; done
> > > 
> > > 
> > > 
> > > Problem description:-
> > > In some filesystems like GPFS below described scenario may happen on some
> > > platforms (Reported-By:- wugyuan)
> > > 
> > > Here, two threads are being run in 2 different shells. Thread-1(cat) does
> > > cat of the symlink and Thread-2(ln) is creating the symlink.
> > > 
> > > Now on any platform with GPFS like filesystem, if CPU does out-of-order
> > > execution (or any kind of re-ordering due compiler optimization?) in
> > > function __d_set_and_inode_type(), then we see a NULL pointer dereference
> > > due to inode->i_uid.
> > > 
> > > This happens because in lookup_fast in nonRCU path or say REF-walk (i.e. in
> > > else condition), we check d_is_negative() without any lock protection.
> > > And since in __d_set_and_inode_type() re-ordering may happen in setting of
> > > dentry->type & dentry->inode => this means that there is this tiny window
> > > where things are going wrong.
> > > 
> > > 
> > > (GPFS like):- Any FS with -inode_operations ->permission callback returning
> > > -ECHILD in case of (mask & MAY_NOT_BLOCK) may cause this problem to happen.
> > > (few e.g. found were - ocfs2, ceph, coda, afs)
> > > 
> > > int xxx_permission(struct inode *inode, int mask)
> > > {
> > >           if (mask & MAY_NOT_BLOCK)
> > >                   return -ECHILD;
> > > 	<...>
> > > }
> > > 
> > > Wugyuan(cc), could reproduce this problem with GPFS filesystem.
> > > Since, I didn't have the GPFS setup, so I tried replicating on a native FS
> > > by forcing out-of-order execution in function __d_set_inode_and_type() and
> > > making sure we return -ECHILD in MAY_NOT_BLOCK case in ->permission
> > > operation for all inodes.
> > > 
> > > With above changes in kernel, I could as well hit this issue on a native FS
> > > too.
> > > 
> > > (basically what we observed is link_path_walk will do nonRCU(REF-walk)
> > > lookup due to may_lookup -> inode_permission return -ECHILD and then
> > > unlazy_walk drops the LOOKUP_RCU flag (nd->flag). After that below race is
> > > possible).
> > > 
> > > 
> > > 
> > > Sequence of events:-
> > > 
> > > Thread-2(Comm: ln)		Thread-1(Comm: cat)
> > > 
> > > 				dentry = __d_lookup() //nonRCU
> > > 
> > > __d_set_and_inode_type() (Out-of-order execution)
> > > 	flags = READ_ONCE(dentry->d_flags);
> > > 	flags &= ~(DCACHE_ENTRY_TYPE | DCACHE_FALLTHRU);
> > > 	flags |= type_flags;
> > > 	WRITE_ONCE(dentry->d_flags, flags);
> > > 
> > > 					
> > > 				if (unlikely(d_is_negative()) // fails
> > >    					{}
> > > 				// since type is already updated in
> > > 				// Thread-2 in parallel but inode
> > > 				// not yet set.
> > > 				// d_is_negative returns false
> > > 
> > > 				*inode = d_backing_inode(path->dentry);
> > > 				// means inode is still NULL
> > > 
> > > 	dentry->d_inode = inode;
> > > 	
> > > 				trailing_symlink()
> > > 					may_follow_link()
> > > 						inode = nd->link_inode;
> > > 						// nd->link_inode = NULL
> > > 						//Then it crashes while
> > > 						//doing inode->i_uid
> > > 					
> > > 	
> > 
> > It seems much similar to
> > https://lore.kernel.org/r/20190419084810.63732-1-houtao1@huawei.com/
> 
> Thanks, yes two same symptoms with different use cases.
> But except the fact that here, we see the issue with GPFS quite frequently.
> So let's hope that we could have some solution to this problem in upstream.
> 
> From the thread:-
> >> We could simply use d_really_is_negative() there, avoiding all that
> >> mess.  If and when we get around to whiteouts-in-dcache (i.e. if
> >> unionfs series gets resurrected), we can revisit that
> 
> I didn't get this part. Does it mean, d_really_is_negative can only be used,
> once whiteouts-in-dcache series is resurrected?
> If yes, meanwhile could we have any other solution in place?

In my own premature opinion, I think it's some complicated about
the coexistence of d_is_negative() and d_really_is_negative(),
and handle both d_flags and d_inode stuffs for negative dentries...

No constructive idea here... Just same case found by our colleagues...

Thanks,
Gao Xiang


> 
> -ritesh
> 
