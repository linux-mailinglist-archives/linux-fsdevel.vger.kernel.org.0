Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867B6616E78
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 21:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiKBUUe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 16:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiKBUUc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:20:32 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03F02DD4
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Nov 2022 13:20:29 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id z26so4274953pff.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Nov 2022 13:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=57kILIoSz8yRVD1E0E9JJTujx9qW1Ms0Hk8p86fG9R0=;
        b=UTtGi7kH0ogYeP8fOIa/6JV1UaS8nmG0fYlTYXrH0o/nTpIddNvCBygQ/RmxLrZM83
         +BJvLRJSyC0nmbKpHKw7AbsPSbwheSZuLvvZiYK1mAbA6rDq2JMSSjpgrRHjZ0gqqAUl
         1kfcY1nXvVnpasriMeR2xRkq8GvbnQSpMNHq3zCcIVWbi95s8+ftsLZjyyO2W1kUGrqG
         Lklh6jBnMeCTle/gcZ8WOhvFVldAfqS+IMoGIYfeX4Bd20wkUkDp2Fc2gVpEly8NdOI8
         PcuOTd3x1p4cOUp4l1BPzSD4LiTYUwUkc4OhcpIQXZqx4WW9+GB0HaZtOZR3PxCuQTBa
         UtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57kILIoSz8yRVD1E0E9JJTujx9qW1Ms0Hk8p86fG9R0=;
        b=2d6BVHL4Jmbj9ymGSadeFqGoSHdOcw8FvL9sJJx8/SccpMkhnBhENQpMKxqIZBO2aN
         HrZqtEGZxYtQLXBKKQ0I0mDzykKeZSF/Y2uQ9/fUOJwwOEokuHXPLSxpiu2R2pYTGMO1
         3rFpxgKetihRkBkaSMb2IgbaCNDD5brx3sAYz4N7DMFFz+XVssy8twWnogjN5HGF3TGw
         lVq+GlolYbn9IXTLmdRRymd160aYB5L5bHfFhTUGDqLe+Sh5Gquqwa8lv3vPVwSgLIIC
         d2Fyn/5QfaSiraIccFFtYOLNJD7T61HCLFRQ76E3FUcDFr+su9z6LlH92f+9E9rowJeL
         hbTg==
X-Gm-Message-State: ACrzQf39gaHKSUm+pRbodXYNREeX95/tS+ONIutvzdekOv7gE/mw/GrL
        633pweqqW3Q6UrUNibwEY5H3ng==
X-Google-Smtp-Source: AMsMyM4ttZ/QS0h6QM0NA77+hhpBabXVgMapZB5cRBsmelv2LbqoJWwnk4zHIZj7U6GkTt9Y1GnbRw==
X-Received: by 2002:a05:6a00:b89:b0:56d:2a21:a6b3 with SMTP id g9-20020a056a000b8900b0056d2a21a6b3mr23147252pfj.56.1667420429319;
        Wed, 02 Nov 2022 13:20:29 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id w14-20020a170902e88e00b00176ae5c0f38sm8514395plg.178.2022.11.02.13.20.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Nov 2022 13:20:28 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <8AAF3B43-BCD3-43B4-BC78-2E9E8E702792@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_205DE4FA-04DF-4681-96DA-4BD0D9C91C0F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: consolidate btrfs checksumming, repair and bio splitting
Date:   Wed, 2 Nov 2022 14:20:24 -0600
In-Reply-To: <20221102062907.GA8619@lst.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        David Sterba <dsterba@suse.cz>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chris Mason <clm@meta.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
To:     Christoph Hellwig <hch@lst.de>
References: <20220901074216.1849941-1-hch@lst.de>
 <347dc0b3-0388-54ee-6dcb-0c1d0ca08d05@wdc.com>
 <20221024144411.GA25172@lst.de>
 <773539e2-b5f1-8386-aa2a-96086f198bf8@meta.com>
 <20221024171042.GF5824@suse.cz>
 <9f443843-4145-155b-2fd0-50613a9f7913@wdc.com>
 <20221026074145.2be5ca09@gandalf.local.home>
 <20221031121912.GY5824@twin.jikos.cz>
 <20221102000022.36df0cc1@rorschach.local.home> <20221102062907.GA8619@lst.de>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_205DE4FA-04DF-4681-96DA-4BD0D9C91C0F
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Nov 2, 2022, at 12:29 AM, Christoph Hellwig <hch@lst.de> wrote:
> 
> On Wed, Nov 02, 2022 at 12:00:22AM -0400, Steven Rostedt wrote:
>> It really comes down to how badly do you want Christoph's code?
> 
> Well, Dave has made it clear implicily that he doesn't seem to care about
> it at all through all this.  The painful part is that I need to come up
> with a series to revert all the code that he refused to add the notice
> for, which is quite involved and includes various bug fixes.

This may be an unpopular opinion for some, but since all of these previous
contributions to the kernel are under GPL, there is no "taking back the
older commits" from the btrfs code.  There is also no basis to prevent the
use/merge/rework or other modifications to GPL code, whether it is part of
btrfs or anywhere else in the kernel.  That is one of the strengths of the
GPL, is that you can't "take it back" after code has been released.  I don't
think anything David has done has violated the terms of the GPL itself.

David, as btrfs maintainer, doesn't even *have* to accept the patches to
revert changes to the btrfs code branch.  The only real option for Christoph
would be to chose not to contribute new fixes to btrfs in the future.


That said, it doesn't make sense to get into a pissing fight about this.
The best solution here is for Christoph and David to come to an amicable
agreement on what copyright notices that David might accept into the btrfs
code.

Cheers, Andreas






--Apple-Mail=_205DE4FA-04DF-4681-96DA-4BD0D9C91C0F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmNi0QgACgkQcqXauRfM
H+CkOBAAvDj60VKg+NfYQyaMaxR2l+tTHmx8rrC9OYh/XtXEYbVQJqG0eJ8i0M/b
WAkJA98JU+HatoWaXIvEkn4Tlec+YIEurQ+swtfuQcomUcEBYASLkL5PvHyIOAFc
naLeoFZ0aWjPwJco9or3CnxXrUCEsAHK21GiG05dga//xK0zD/89iiLVSM54fOOu
fKS8LW3vAOrqSiwHbxmnP4lGCvLT4mSbtSQXUlb8MsxYWtdj9CurzdKWhQ2P33X2
e7hexB/cs6dO9C9peXcq5oe8DfQArv2qWwiRNnBqrhtUMTdpdBYo1mtW8zRvciwt
4Q5gDHhScFS86CTqcDapzGfl6FAmHcOAyMvfcMckewGVniBpPzSuF2o81yzJppO+
OIiXn4BUHexjSCJUoE98Pfkh3ynxNsth90Mb54czuNzVYZk4LelJ7B+fp0bG/Oju
YBsDzLkIPcpfgnCQlE9dC+yRvpUSBZ9z0BQCy9VQl1TW87oJuZMDmnCy/IdjhpzV
vnx30N9hYJMwqZk4J/+BkIq6BgIjDx0q7cAPOw9sEo2CPpRnPS6iyJYJBGyis8MA
ozNInSrq2KLphmpr0S2RgRfN5USssQSSFh36q1mJHz7g1gTGpWTZUkfkXr4SaMVv
asQVM8j7SQYJOc2k+xkzn8hjztFVs6d6LRXO0Y/poSHsc38B0xg=
=8yPT
-----END PGP SIGNATURE-----

--Apple-Mail=_205DE4FA-04DF-4681-96DA-4BD0D9C91C0F--
