Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F873B5D4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 08:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfIRGdL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 02:33:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41421 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfIRGdK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:33:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so3387790pgg.8;
        Tue, 17 Sep 2019 23:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4NRHniZPjEfTKvj18POaDeXjVS6m4zvsqMwOtmFk3z0=;
        b=r3C+u3/BB++MIH+IsmGmDFs2M0PdO8Pau3WSslLy1WJtLJ3S7piwCY3PHTNxaBHfF0
         4ms7Nh5DunKVrPLSEg5PphOgFpwy7xXtIAwixb738v0lzn0t2u/6COg2bvxa8azBVXWs
         QYIkYpT1OVRIZOvfysvnbaCeri03UJY8KotnUrAAfySUN86jCxk243As4uNuVzbR60eo
         x+GFT1forrnz6r38ro+RZtuK6NXLnNos8WcySSUJV+yJSub2Cmv6+VJSg7KG0yeMnj7V
         JJb/We+Px/j7j8JPH+3lqnYZtxz6QdupO4RzerpyBEpznnp39WLjQv6Wu/4mOBnitfD1
         NK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4NRHniZPjEfTKvj18POaDeXjVS6m4zvsqMwOtmFk3z0=;
        b=SiuDvAF85sspmxrrghQiMYPBPrQHXBgC33uThlFcQ5cCXvhh238328laMrBO8gqqW3
         tcSk9kiBqcFnDzv9+TTF1+6Z79wfvqfYCFC4Wr16Fmvn3P4SPPTiwLSOffAQT0+ah6Yo
         cD+AMe7GW86dCnpt84VKkWrynTwainF/BST01OypujXkrElSp7nXqI1lyYN63QNPBhbL
         QE/2zR9wV/FAGebRwkchwy3/x82u3vvPVV4kMGbgF3tAobzQdHlb8VlXoxp2YMuePfS3
         xnpBhar9qZeAcHYDpcxLihcnFveVoIvfkroB3+pjbF0E3e89+BrKgIwlcC9Cxp/1xHjD
         4YZg==
X-Gm-Message-State: APjAAAWiJ9FEYkXSLVYbhMRLDfqBiNQN51bmk929r/tftN93ZBqjCq1Q
        meUo+oKEf603yK8P97+17cA=
X-Google-Smtp-Source: APXvYqxbYV70nhx6LQt0f1LP4Q/8C+7DUVaCoQwC8bHmHjNOPx3Cn+Y7wUTauxXkxk/8TXzoWnjcVQ==
X-Received: by 2002:aa7:93b7:: with SMTP id x23mr2433584pff.250.1568788389488;
        Tue, 17 Sep 2019 23:33:09 -0700 (PDT)
Received: from localhost ([175.223.34.14])
        by smtp.gmail.com with ESMTPSA id r185sm6685309pfr.68.2019.09.17.23.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 23:33:08 -0700 (PDT)
Date:   Wed, 18 Sep 2019 15:33:04 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     'Greg KH' <gregkh@linuxfoundation.org>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        'Ju Hyung Park' <qkrwngud825@gmail.com>,
        'Valdis Kletnieks' <valdis.kletnieks@vt.edu>,
        devel@driverdev.osuosl.org, linkinjeon@gmail.com,
        linux-kernel@vger.kernel.org, alexander.levin@microsoft.com,
        sergey.senozhatsky@gmail.com, linux-fsdevel@vger.kernel.org,
        sj1557.seo@samsung.com
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to
Message-ID: <20190918063304.GA8354@jagdpanzerIV>
References: <8998.1568693976@turing-police>
 <20190917053134.27926-1-qkrwngud825@gmail.com>
 <20190917054726.GA2058532@kroah.com>
 <CGME20190917060433epcas2p4b12d7581d0ac5477d8f26ec74e634f0a@epcas2p4.samsung.com>
 <CAD14+f1adJPRTvk8awgPJwCoHXSngqoKcAze1xbHVVvrhSMGrQ@mail.gmail.com>
 <004401d56dc9$b00fd7a0$102f86e0$@samsung.com>
 <20190918061605.GA1832786@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918061605.GA1832786@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On (09/18/19 08:16), 'Greg KH' wrote:
[..]
> > Note, that Samsung is still improving sdfat driver. For instance,
> > what will be realeased soon is sdfat v2.3.0, which will include support
> > for "UtcOffset" of "File Directory Entry", in order to satisfy
> > exFAT specification 7.4.
>
[..]
> If Samsung wishes to use their sdfat codebase as the "seed" to work from
> for this, please submit a patch adding the latest version to the kernel
> tree and we can compare and work from there.

Isn't it what Ju Hyung did? He took sdfat codebase (the most recent
among publicly available) as the seed, cleaned it up a bit and submitted
as a patch. Well, technically, Valdis did the same, it's just he forked
a slightly more outdated (and not anymore used by Samsung) codebase.

	-ss
