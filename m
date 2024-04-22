Return-Path: <linux-fsdevel+bounces-17390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA6B8ACF43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 16:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8801C215BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 14:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EC11514F0;
	Mon, 22 Apr 2024 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="aqck/wF7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F261514E3;
	Mon, 22 Apr 2024 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713795789; cv=none; b=Z1KtpHA341FczgMVm8YtF/xrs2REBDo2JGcNSzjAzU0+5Zy8qGZGp9Xa3NFYD1fa2dQxFgE2DCWQjEiRayw6eDK9X49fy34keD39ai9yg8grwm7ZCRC8oQbBLCDjVR4tZXgg4Mcg+/yeF3+47PFOKb3DdmL+7U7fun33Bz1Chng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713795789; c=relaxed/simple;
	bh=kIUZhHXjEVfH89M7nP58Ng1lTx2knM+2pUZBTbgvVT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIluStVMiZddZloUb7AtbdUmT2rxB7Qx8Zae+2AGCIj2/lAGVlscvhB5tjDzGn+RajHU/b/lWWEfxtrrpu3CFc79g6IugX4wokr6R8ubN4pErUD1X2Nax4I/tup1Ly21IIJscdaOYLLjwmRr1Tdbk0fiQu5kWpOIKKkPpOqG5gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=aqck/wF7; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4VNRzd1NzNz9smg;
	Mon, 22 Apr 2024 16:13:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1713795181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2fn+fkItYrtFhHWLrzL9UxC0oz2DQmib0IIGep25rEs=;
	b=aqck/wF7YSC/YDylTK/FcHTeWKrgG1Npt9mqhibqTMZu6/yX3Si4LF5erTKf9XMPJe13Si
	7oGhGc7banDEcJgu4m2gIKodhToraxT/ufXWqmOe1NB6ZfTLMa0JjifrtfGWZgBs887er0
	rtcOZh2RUyYwz7vvUXbBEbVIJ+h9emNftV6w6hdQNzuFljmxjG3VzedXyAr5bWmFErh+rd
	VahIJn4ReXkuU7v6rzTkQYYCUp7KCX1oiaFJiKQ5R6CABjBQdqUTXJ5GQ6CAPQ9+WBrM+F
	MTR3scBjjRktiNxvcJ1HtgiPtXIcEAsOTch+7ZPabcqbekH30AiPGFyBm6DUfQ==
Date: Mon, 22 Apr 2024 16:12:56 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	willy@infradead.org, p.raghav@samsung.com, da.gomez@samsung.com, hare@suse.de, 
	john.g.garry@oracle.com, linux-xfs@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [RFC] fstests: add mmap page boundary tests
Message-ID: <5xt5ultarn7rkidw66ii2kceobb3t2d4pqtfvzogmuk23zcdqh@dzvknx352vsg>
References: <20240415081054.1782715-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415081054.1782715-1-mcgrof@kernel.org>
X-Rspamd-Queue-Id: 4VNRzd1NzNz9smg

On Mon, Apr 15, 2024 at 01:10:54AM -0700, Luis Chamberlain wrote:
> mmap() POSIX compliance says we should zero fill data beyond a file
> size up to page boundary, and issue a SIGBUS if we go beyond. While fsx
> helps us test zero-fill sometimes, fsstress also let's us sometimes test
> for SIGBUS however that is based on a random value and its not likley we
> always test it. Dedicate a specic test for this to make testing for
> this specific situation and to easily expand on other corner cases.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> 
> Does enough to get us to use to test this, however I'm aware of a bit
> more polishing up to do:
> 
>   * maybe moving mread to common as generic/574 did it first
>   * sharing round_up_to_page_boundary() as well
> 
> generic/574 is special, it was just testing for correctness of
> integrity if we muck with mmap() however if you don't have verity
> stuff available obviously you won't end up testing it.
> 
> This generalizes mmap() zero-fill and SIGBUS corner case tests.
> 
> I've tested so far only 4k and it works well there. For 16k bs on LBS
> just the SIGBUS issue exists, I'll test smaller block sizes later like
> 512, 1k, 2k as well. We'll fix triggering the SIBGUS when LBS is used,
> we'll address that in the next iteration.
> 
> Is this a worthy test as a generic test?
> 
>  common/filter         |   6 ++
>  tests/generic/740     | 231 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/740.out |   2 +
>  3 files changed, 239 insertions(+)
>  create mode 100755 tests/generic/740
>  create mode 100644 tests/generic/740.out
> 
We could also extend the test to include mmap writes. 

I took the lazy approach here but I think we can make the code look 
prettier by adding some more functions that can do both mmap read and writes.

diff --git a/tests/generic/740 b/tests/generic/740
index cbb82301..93663964 100755
--- a/tests/generic/740
+++ b/tests/generic/740
@@ -53,6 +53,25 @@ round_up_to_page_boundary()
        echo $(( (n + page_size - 1) & ~(page_size - 1) ))
 }
 
+mwrite()
+{
+       local file=$1
+       local map_len=$2
+       local offset=$3
+       local length=$4
+
+       # Some callers expect xfs_io to crash with SIGBUS due to the mread,
+       # causing the shell to print "Bus error" to stderr.  To allow this
+       # message to be redirected, execute xfs_io in a new shell instance.
+       # However, for this to work reliably, we also need to prevent the new
+       # shell instance from optimizing out the fork and directly exec'ing
+       # xfs_io.  The easiest way to do that is to append 'true' to the
+       # commands, so that xfs_io is no longer the last command the shell sees.
+       bash -c "trap '' SIGBUS; $XFS_IO_PROG $file \
+               -c 'mmap -w 0 $map_len' \
+               -c 'mwrite $offset $length'; true"
+}
+
 mread()
 {
        local file=$1
@@ -180,6 +199,12 @@ do_mmap_tests()
                        _fail
                fi
 
+               # This should just work
+               mwrite $test_file $map_len 0 $map_len >> $seqres.full  2>$tmp.err
+               if [[ $? -ne 0 ]]; then
+                       _fail
+               fi
+
                # If we mmap() on the boundary but try to read beyond it just
                # fails, we don't get a SIGBUS
                $XFS_IO_PROG -r $test_file \
@@ -192,12 +217,29 @@ do_mmap_tests()
                        _fail
                fi
 
+               $XFS_IO_PROG -w $test_file \
+                       -c "mmap -w 0 $map_len" \
+                       -c "mwrite 0 $((map_len + 10))" >> $seqres.full  2>$tmp.err
+               local mwrite_err=$?
+               if [[ $mwrite_err -eq 0 ]]; then
+                       echo "mmap() to page boundary works as expected but writing beyond should fail"
+                       echo "err: $?"
+                       _fail
+               fi
+
                # Now let's go beyond the allowed mmap() page boundary
                mread $test_file $((map_len + 10)) 0 $((map_len + 10)) >> $seqres.full  2>$tmp.err
                if ! grep -q 'Bus error' $tmp.err; then
                        echo "Expected SIGBUS when mmap() reading beyond page boundary"
                        _fail
                fi
+
+               mwrite $test_file $((map_len + 10)) 0 $((map_len + 10)) >> $seqres.full  2>$tmp.err
+               if ! grep -q 'Bus error' $tmp.err; then
+                       echo "Expected SIGBUS when mmap() writing beyond page boundary"
+                       _fail
+               fi
+
                local filelen_test=$(_get_filesize $test_file)
                if [[ "$filelen_test" != "$new_filelen" ]]; then
                        echo "Expected file length: $new_filelen"


--
Pankaj

