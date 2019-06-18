Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D65694980C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 06:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfFREWK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 00:22:10 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36915 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfFREWK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 00:22:10 -0400
Received: by mail-yw1-f67.google.com with SMTP id 186so6146015ywo.4;
        Mon, 17 Jun 2019 21:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O/e6oChE/SyWwcr8V43QSlktsHCMhOSjzZgZjKIDmbw=;
        b=Id6Dkb+OAISGpA7/dwti39nTRuE6OM/yt7qQwPndxItn9HId851U8V2uFGhuDrezPD
         xCdFsb35uG/XRURQlbOeyFEX0f4X1nMohBFkpbcnpd+1Nhs+hirO49yOfjg+kKtCBVFy
         b9aAORh9LBx6BhTY5QE+k5tM1Fvl0J8B8kHjQzsmrU6zyCH78b4cLuS6E1yjEzBpf9HK
         VzNNfoLMhlyVSX0wVlES46FdhXna5J0CzYEKc7xe5UyqX8v5190/qdL6e0TBEQIKF1He
         hhtU2WjOb0FBmi4ya7lZCzx6NWgDDaD3YbsxBw5yJFCv9dCM0zSLMcfPeqUiTZ4UMpDY
         UAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O/e6oChE/SyWwcr8V43QSlktsHCMhOSjzZgZjKIDmbw=;
        b=RrpOd3rEjQNhTRZ4ZAb+p7fUhnECWhjohArOL1WiX3m7XYFpgmnqUYCEWyLsIpHy5Y
         1IuXTSLmrJTcioj5G1n5rdHZLtKstYdv1qakAPNHvpCAG88xrrgV4XUMoxmn7bnmjf+X
         oruXtkfYNLaAFA6kwriwf8XOApfJ5YBUOx6d8nNm07GuXAE0VqsS/uoXrtu8coIjC52y
         MR/8kRDcsGTyohdK9Ptc0EwZTjLS+piZ0SudpGrZ5AUB6BhmldJwn7kAZnhP5XDClSoN
         bRt614OUM4HOFTUtwYI/smEyAflbQNNWtIFdX5mdTC4YB5v8ZKO8IZPVuKwo107vT01I
         hVcA==
X-Gm-Message-State: APjAAAWyzMSUJpgwtWWx/yDbwwJvWHMRfBn+iSQqGhql23Luu4EYAo6b
        d04t/GEYd5XaRhpT88wSbTCm25j6pArL22NyUd4=
X-Google-Smtp-Source: APXvYqxyWd2OUJz3lm3qLic/xBextIZd8t5Vt6/SH/uSkue7iJOhfKsYpVnLiGBcx2G+cPv2/b2R5nZlkGpCm/aiRjc=
X-Received: by 2002:a81:50d5:: with SMTP id e204mr11277861ywb.379.1560831729476;
 Mon, 17 Jun 2019 21:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com>
 <20190611011737.GA28701@kmo-pixel> <20190611043336.GB14363@dread.disaster.area>
 <20190612162144.GA7619@kmo-pixel> <20190612230224.GJ14308@dread.disaster.area>
 <20190613183625.GA28171@kmo-pixel> <20190613235524.GK14363@dread.disaster.area>
 <CAHk-=whMHtg62J2KDKnyOTaoLs9GxcNz1hN9QKqpxoO=0bJqdQ@mail.gmail.com>
 <CAHk-=wgz+7O0pdn8Wfxc5EQKNy44FTtf4LAPO1WgCidNjxbWzg@mail.gmail.com>
 <20190617224714.GR14363@dread.disaster.area> <CAHk-=wiR3a7+b0cUN45hGp1dvFh=s1i1OkVhoP7CivJxKqsLFQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiR3a7+b0cUN45hGp1dvFh=s1i1OkVhoP7CivJxKqsLFQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 18 Jun 2019 07:21:56 +0300
Message-ID: <CAOQ4uxjqQjrCCt=ixgdUYjBJvKLhw4R9NeMZOB_s2rrWvoDMBw@mail.gmail.com>
Subject: Re: pagecache locking (was: bcachefs status update) merged)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > Right, but regardless of the spec we have to consider that the
> > behaviour of XFS comes from it's Irix heritage (actually from EFS,
> > the predecessor of XFS from the late 1980s)
>
> Sure. And as I mentioned, I think it's technically the nicer guarantee.
>
> That said, it's a pretty *expensive* guarantee. It's one that you
> yourself are not willing to give for O_DIRECT IO.
>
> And it's not a guarantee that Linux has ever had. In fact, it's not
> even something I've ever seen anybody ever depend on.
>
> I agree that it's possible that some app out there might depend on
> that kind of guarantee, but I also suspect it's much much more likely
> that it's the other way around: XFS is being unnecessarily strict,
> because everybody is testing against filesystems that don't actually
> give the total atomicity guarantees.
>
> Nobody develops for other unixes any more (and nobody really ever did
> it by reading standards papers - even if they had been very explicit).
>
> And honestly, the only people who really do threaded accesses to the same file
>
>  (a) don't want that guarantee in the first place
>
>  (b) are likely to use direct-io that apparently doesn't give that
> atomicity guarantee even on xfs
>
> so I do think it's moot.
>
> End result: if we had a really cheap range lock, I think it would be a
> good idea to use it (for the whole QoI implementation), but for
> practical reasons it's likely better to just stick to the current lack
> of serialization because it performs better and nobody really seems to
> want anything else anyway.
>

This is the point in the conversation where somebody usually steps in
and says "let the user/distro decide". Distro maintainers are in a much
better position to take the risk of breaking hypothetical applications.

I should point out that even if "strict atomic rw" behavior is desired, then
page cache warmup [1] significantly improves performance.
Having mentioned that, the discussion can now return to what is the
preferred way to solve the punch hole vs. page cache add race.

XFS may end up with special tailored range locks, which beings some
other benefits to XFS, but all filesystems need the solution for the punch
hole vs. page cache add race.
Jan recently took a stab at it for ext4 [2], but that didn't work out.
So I wonder what everyone thinks about Kent's page add lock as the
solution to the problem.
Allegedly, all filesystems (XFS included) are potentially exposed to
stale data exposure/data corruption.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20190404165737.30889-1-amir73il@gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20190603132155.20600-3-jack@suse.cz/
