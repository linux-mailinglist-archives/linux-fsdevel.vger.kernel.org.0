Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54EA31EA14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 13:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbhBRMz4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 07:55:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:59146 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232406AbhBRKb0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:31:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 693E2AD2B;
        Thu, 18 Feb 2021 10:28:06 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id c89a0fc7;
        Thu, 18 Feb 2021 10:29:09 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] vfs: prevent copy_file_range to copy across devices
References: <CAOQ4uxiFGjdvX2-zh5o46pn7RZhvbGHH0wpzLPuPOom91FwWeQ@mail.gmail.com>
        <20210215154317.8590-1-lhenriques@suse.de>
        <20210218074207.GA329605@infradead.org>
        <CAOQ4uxgreB=TywvWQXfcHYMBcFm5OKSdwUC8YJY1WuVja6PccQ@mail.gmail.com>
Date:   Thu, 18 Feb 2021 10:29:08 +0000
In-Reply-To: <CAOQ4uxgreB=TywvWQXfcHYMBcFm5OKSdwUC8YJY1WuVja6PccQ@mail.gmail.com>
        (Amir Goldstein's message of "Thu, 18 Feb 2021 11:10:00 +0200")
Message-ID: <87v9apis97.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

> On Thu, Feb 18, 2021 at 9:42 AM Christoph Hellwig <hch@infradead.org> wrote:
>>
>> Looks good:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>
>> This whole idea of cross-device copie has always been a horrible idea,
>> and I've been arguing against it since the patches were posted.
>
> Ok. I'm good with this v2 as well, but need to add the fallback to
> do_splice_direct()
> in nfsd_copy_file_range(), because this patch breaks it.
>
> And the commit message of v3 is better in describing the reported issue.

Except that, as I said in a previous email, v2 doesn't really fix the
issue: all the checks need to be done earlier in generic_copy_file_checks().

I'll work on getting v4, based on v2 and but moving the checks and
implementing your review suggestions to v3 (plus this nfs change).

Cheers,
-- 
Luis
