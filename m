Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 625741A2E8D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 06:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgDIExp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 00:53:45 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41638 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgDIExp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 00:53:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id n17so10033180lji.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Apr 2020 21:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pKIxs2zRm8OT5XpGNIVtZkNiB0y/6Wwatz3SR/493kg=;
        b=M3rzrXf8/eHi7ET8nMXxx5gyYyNZXr8XRM5XElcbL9uYgSqzUFsyRITiDs2cP3QACa
         X2vBb3j54lhh/qWVj64q1RlLTd8a/iLwfYX435p3ieCor3aDgOTWRJT02f80d7stvV+z
         fG4Zmmnr7nRdXh895Mxr3zKTXfwIwKA8dL0fY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pKIxs2zRm8OT5XpGNIVtZkNiB0y/6Wwatz3SR/493kg=;
        b=H6KBB/k+wJ9VXFWLGMuqb4a1un7pFLU3+qOl9kDP0PlWtxuJt+ISezpgkXHVhbkCFJ
         mdJKnLKNelISCcky9cOzhhs/Vl3GmY3x+QdBkKLHmtoGDMnDsYVAR/NFumWBBKw1g2oA
         XzM6s3BksTs8aCHUzV7+uNS162DBxHKCijAwaexMpJgPPuNmARIpF0GCOJpn26LE4iqE
         +JyoSUCaxfh1uy4wXhxPF5eJH7f5Vab17S7sZiUw4RME9O4jWAQp57gZUZQaBU+QtWBX
         Ce3qDjS/EXSaJdPftFbh163+DlYyl1HEeiRWMX+ODjrY8fI5O8WChdlfHeBT56bv60l3
         HEAg==
X-Gm-Message-State: AGi0PubUY9BM0BjrFF3wMPzDVbcil3AuCNS6hP3j6e2bdMJjEGXXKlVI
        Q2N/MpWCaa7NEft5CJU6p0TqP2vGicU=
X-Google-Smtp-Source: APiQypLoH6ECHKtwWvhkKPhwG1kcdwhAw/k+XneIVE+i6rHiIxvyUkKzjD7CiRSft3Eg26EMpUhBEQ==
X-Received: by 2002:a2e:7004:: with SMTP id l4mr7243248ljc.55.1586408022726;
        Wed, 08 Apr 2020 21:53:42 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id t8sm17184942lfe.31.2020.04.08.21.53.41
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 21:53:41 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id z23so6891959lfh.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Apr 2020 21:53:41 -0700 (PDT)
X-Received: by 2002:a05:6512:14a:: with SMTP id m10mr6567600lfo.152.1586408021187;
 Wed, 08 Apr 2020 21:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200406110702.GA13469@nautica> <20200408151214.GA30977@nautica>
In-Reply-To: <20200408151214.GA30977@nautica>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Apr 2020 21:53:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjdwUbCfaMnXRrctDD_ftBRJwbH+x3GtSOJyR1Gtm=HXA@mail.gmail.com>
Message-ID: <CAHk-=wjdwUbCfaMnXRrctDD_ftBRJwbH+x3GtSOJyR1Gtm=HXA@mail.gmail.com>
Subject: Re: [GIT PULL v2] 9p update for 5.7
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 8, 2020 at 8:12 AM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> v2 of monday's pull request. The commit date is just now, but that is
> just the documentation patch I applied, there is no code change since
> the last version.

Note that I had already pulled your previous request, I just inquired
about the behavior.

I now pulled the doc update too.

            Linus
