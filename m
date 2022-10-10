Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4A65FA10E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 17:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiJJPWJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 11:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJJPWI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 11:22:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2D772FD8;
        Mon, 10 Oct 2022 08:22:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18A6EB80F9C;
        Mon, 10 Oct 2022 15:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC74AC433D6;
        Mon, 10 Oct 2022 15:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665415323;
        bh=no8M4HUxUtn5Brrmm9/Iz2cSzyV90e+SLK8FcxAraaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R2tYg+5KCSYc6jNCKReLmD6NGukEbLxjOw6Ke9/ZGGzU6X0QkmgPVG7y8QDl5PdDH
         A6/eBBN0s91iP9x57tXd0mgu+JbObaMe679zYY64fKSllcg1Yp9NT5KUKaAWSkxps/
         WQN8v9qzBdTAR5Zwb2sN1xZCjegHDRX/Ck7UkOe0NVV7/N43RVWA1Nz7iPgk0jl6cb
         l2U0A/7uDEXYEnNXCCu37Z8bosr1ZywkOAQpj8qj12dmsQpHIkDda3KkaS+Iy17XXR
         Pvn2BXARrTdcMrMCXuV/xDh7yhRcnMBZIl2BKXEmnmmPHOg4EHte7ZTfQjKGpoqLU6
         mqCUxVAhSe09A==
Date:   Mon, 10 Oct 2022 08:22:03 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-man@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [man-pages PATCH v3] statx.2, open.2: document STATX_DIOALIGN
Message-ID: <Y0Q4m9mj3DUZEkrW@magnolia>
References: <20221004174307.6022-1-ebiggers@kernel.org>
 <26cafc28-e63a-6f13-df70-8ccec85a4ef0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26cafc28-e63a-6f13-df70-8ccec85a4ef0@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 08, 2022 at 03:56:22AM +0200, Alejandro Colomar wrote:
> Hi Eric,
> 
> On 10/4/22 19:43, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Document the STATX_DIOALIGN support for statx()
> > (https://git.kernel.org/linus/725737e7c21d2d25).
> > 
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Please see some formatting comments below.
> 
> > ---
> > 
> > I'm resending this now that support for STATX_DIOALIGN has been merged
> > upstream.
> 
> Thanks.
> 
> Cheers,
> Alex
> 
> > 
> > v3: updated mentions of Linux version, fixed some punctuation, and added
> >      a Reviewed-by
> > 
> > v2: rebased onto man-pages master branch, mentioned xfs, and updated
> >      link to patchset
> > 
> >   man2/open.2  | 43 ++++++++++++++++++++++++++++++++-----------
> >   man2/statx.2 | 29 +++++++++++++++++++++++++++++
> >   2 files changed, 61 insertions(+), 11 deletions(-)
> > 
> > diff --git a/man2/open.2 b/man2/open.2
> > index deba7e4ea..b8617e0d2 100644
> > --- a/man2/open.2
> > +++ b/man2/open.2
> > @@ -1732,21 +1732,42 @@ of user-space buffers and the file offset of I/Os.
> >   In Linux alignment
> >   restrictions vary by filesystem and kernel version and might be
> >   absent entirely.
> > -However there is currently no filesystem\-independent
> > -interface for an application to discover these restrictions for a given
> > -file or filesystem.
> > -Some filesystems provide their own interfaces
> > -for doing so, for example the
> > +The handling of misaligned
> > +.B O_DIRECT
> > +I/Os also varies; they can either fail with
> > +.B EINVAL
> > +or fall back to buffered I/O.
> > +.PP
> > +Since Linux 6.1,
> > +.B O_DIRECT
> > +support and alignment restrictions for a file can be queried using
> > +.BR statx (2),
> > +using the
> > +.B STATX_DIOALIGN
> > +flag.
> > +Support for
> > +.B STATX_DIOALIGN
> > +varies by filesystem; see
> > +.BR statx (2).
> > +.PP
> > +Some filesystems provide their own interfaces for querying
> > +.B O_DIRECT
> > +alignment restrictions, for example the
> >   .B XFS_IOC_DIOINFO
> >   operation in
> >   .BR xfsctl (3).
> > +.B STATX_DIOALIGN
> > +should be used instead when it is available.
> >   .PP
> > -Under Linux 2.4, transfer sizes, the alignment of the user buffer,
> > -and the file offset must all be multiples of the logical block size
> > -of the filesystem.
> > -Since Linux 2.6.0, alignment to the logical block size of the
> > -underlying storage (typically 512 bytes) suffices.
> > -The logical block size can be determined using the

I'm not so familiar with semantic newlines-- is there an automated
reflow program that fixes these problems mechanically, or is this
expected to be performed manually by manpage authors?

If manually, do the items in a comma-separated list count as clauses?

Would the next two paragraphs of this email reformat into semantic
newlines like so?

	In the source of a manual page,
	new sentences should  be started on new lines,
	long sentences should be split into lines at clause breaks
	(commas, semicolons, colons, and so on),
	and long clauses should be split at phrase boundaries.
	This convention,
	sometimes known as "semantic newlines",
	makes it easier to see the effect of patches,
	which often operate at the level of individual sentences, clauses, or phrases.

Do we still line-wrap at 72^W74^W78^W80 columns?

and would the proposed manpage text read:

	If none of the above is available,
	then direct I/O support and alignment restrictions can only be assumed
	from known characteristics of the filesystem,
	the individual file,
	the underlying storage device(s),
	and the kernel version.
	In Linux 2.4,
	most block device based filesystems require that the file offset and the
	length and memory address of all I/O segments be multiples of the
	filesystem block size
	(typically 4096 bytes).
	In Linux 2.6.0,
	this was relaxed to the logical block size of the block device
	(typically 512 bytes).
	A block device's logical block size can be determined using the
	.BR ioctl (2)
	.B BLKSSZGET
	operation or from the shell using the command:

--D

> > +If none of the above is available, then direct I/O support and alignment
> 
> Please use semantic newlines.
> 
> See man-pages(7):
>    Use semantic newlines
>        In the source of a manual page, new sentences  should  be
>        started on new lines, long sentences should be split into
>        lines  at  clause breaks (commas, semicolons, colons, and
>        so on), and long clauses should be split at phrase bound‐
>        aries.  This convention,  sometimes  known  as  "semantic
>        newlines",  makes it easier to see the effect of patches,
>        which often operate at the level of individual sentences,
>        clauses, or phrases.
> 
> 
> > +restrictions can only be assumed from known characteristics of the filesystem,
> > +the individual file, the underlying storage device(s), and the kernel version.
> > +In Linux 2.4, most block device based filesystems require that the file offset
> > +and the length and memory address of all I/O segments be multiples of the
> > +filesystem block size (typically 4096 bytes).
> > +In Linux 2.6.0, this was relaxed to the logical block size of the block device
> > +(typically 512 bytes).
> > +A block device's logical block size can be determined using the
> >   .BR ioctl (2)
> >   .B BLKSSZGET
> >   operation or from the shell using the command:
> > diff --git a/man2/statx.2 b/man2/statx.2
> > index 0d1b4591f..50397057d 100644
> > --- a/man2/statx.2
> > +++ b/man2/statx.2
> > @@ -61,7 +61,12 @@ struct statx {
> >          containing the filesystem where the file resides */
> >       __u32 stx_dev_major;   /* Major ID */
> >       __u32 stx_dev_minor;   /* Minor ID */
> > +
> >       __u64 stx_mnt_id;      /* Mount ID */
> > +
> > +    /* Direct I/O alignment restrictions */
> > +    __u32 stx_dio_mem_align;
> > +    __u32 stx_dio_offset_align;
> >   };
> >   .EE
> >   .in
> > @@ -247,6 +252,8 @@ STATX_BTIME	Want stx_btime
> >   STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
> >   	It is deprecated and should not be used.
> >   STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
> > +STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align
> > +	(since Linux 6.1; support varies by filesystem)
> >   .TE
> >   .in
> >   .PP
> > @@ -407,6 +414,28 @@ This is the same number reported by
> >   .BR name_to_handle_at (2)
> >   and corresponds to the number in the first field in one of the records in
> >   .IR /proc/self/mountinfo .
> > +.TP
> > +.I stx_dio_mem_align
> > +The alignment (in bytes) required for user memory buffers for direct I/O
> > +.BR "" ( O_DIRECT )
> 
> .RB and remove the "".
> 
> > +on this file, or 0 if direct I/O is not supported on this file.
> > +.IP
> > +.B STATX_DIOALIGN
> > +.IR "" ( stx_dio_mem_align
> 
> .RI
> 
> > +and
> > +.IR stx_dio_offset_align )
> > +is supported on block devices since Linux 6.1.
> > +The support on regular files varies by filesystem; it is supported by ext4,
> > +f2fs, and xfs since Linux 6.1.
> > +.TP
> > +.I stx_dio_offset_align
> > +The alignment (in bytes) required for file offsets and I/O segment lengths for
> > +direct I/O
> > +.BR "" ( O_DIRECT )
> > +on this file, or 0 if direct I/O is not supported on this file.
> > +This will only be nonzero if
> > +.I stx_dio_mem_align
> > +is nonzero, and vice versa.
> >   .PP
> >   For further information on the above fields, see
> >   .BR inode (7).
> > 
> > base-commit: bc28d289e5066fc626df260bafc249846a0f6ae6
> 
> -- 
> <http://www.alejandro-colomar.es/>



