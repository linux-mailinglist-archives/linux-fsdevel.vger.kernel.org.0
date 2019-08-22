Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 152349969C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 16:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733009AbfHVO37 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 10:29:59 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:37498 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732974AbfHVO36 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:29:58 -0400
Received: by mail-wr1-f42.google.com with SMTP id z11so5657890wrt.4;
        Thu, 22 Aug 2019 07:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=tLNXP86xJdI97QkQX4COi/mM+VMKt9pcSlHlaNIVz3o=;
        b=iyDcrcA+H5zHrvrLuvsD0FGyWdEnoRBnP5IbVJbAX47byUeQcv8lHU84Xm5VT5nGYG
         S2FtpHG9cc3I2vlacEXtugl8kiRwpnCL2UvkqcWshkSUztVfYMywxMfmv8wlWPJkEQ1c
         lg1A+MIWM75RofPFS0CELUC4f0lhWgxu9tdBm43G6o2QGw/ViERIKzaORmguy7iEPRfF
         ZPN24ZzULsp2RNdtWZKHMujvyksYfzpeN/PSL699h/tNMh2/OFcLT63+WEM1fr/lF/NT
         EkJjPsY8DEnEe1sMTWpKKLtwlfUO2yFZv0KwscFI1z7+/NAVcMO1F+nNxKWmloP6J3cH
         rbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=tLNXP86xJdI97QkQX4COi/mM+VMKt9pcSlHlaNIVz3o=;
        b=AqWCL2n8syRaX0u8ig/50gquOCyiEe89meLl/E6aMlvhfWAPkZ23CdqhHyXSXriSfM
         1OJ2SdP+RXX8LTJ2OG1OQe2gZcMc8o1TZ+bhsbyNS+T3CeURRXJqPB/CvXWurgNH9PUk
         aPR7rRGRbjLt0kN0UjZ4yAZBlrimn8yvJ4GbqrcOsAKEKWvk23tXzSorE5/WBlChVrad
         WPT7R7IbZG7oGqgcLB4nVRACjO+AZ7SOLQckKcbNSe6XjodDzH5c/hnprCGHb4YGh79e
         lj7oqaeW2VhPqnpT5mGywPAoP9Bk9TaaITFax+5CJfXKx3ThpgOJwPShbqR1yOtkwt33
         3f2A==
X-Gm-Message-State: APjAAAX6/shEE8jWi3+XE3VsBFK+LDuJLqNoluTY5OCH1GYEfVjIGtER
        Xdh8OvS9C8wZyMRX/lfJcRzB9NBs3Ii4wPx7w+M=
X-Google-Smtp-Source: APXvYqxzEvl4Wcc2eUsw9vwyB9jMPZsmg4spjFSLqSHbNLUQD5btzjrokrfIgE3/duKUgktNGPkNfh/tXryV41xqJu4=
X-Received: by 2002:a05:6000:12c3:: with SMTP id l3mr47095595wrx.100.1566484196685;
 Thu, 22 Aug 2019 07:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <1323459733.69859.1566234633793.JavaMail.zimbra@nod.at>
 <20190819204504.GB10075@hsiangkao-HP-ZHAN-66-Pro-G1> <CAFLxGvxr2UMeVa29M9pjLtWMFPz7w6udRV38CRxEF1moyA9_Rw@mail.gmail.com>
 <20190821220251.GA3954@hsiangkao-HP-ZHAN-66-Pro-G1> <CAFLxGvzLPgD22pVOV_jz1EvC-c7YU_2dEFbBt4q08bSkZ3U0Dg@mail.gmail.com>
 <20190822142142.GB2730@mit.edu>
In-Reply-To: <20190822142142.GB2730@mit.edu>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Thu, 22 Aug 2019 16:29:44 +0200
Message-ID: <CAFLxGvzGEBH2Z+Bpv68OMeLR1JH0pe6bHn6P-sBG+epLTXbR6w@mail.gmail.com>
Subject: Re: erofs: Question on unused fields in on-disk structs
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Gao Xiang <hsiangkao@aol.com>,
        Richard Weinberger <richard@nod.at>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 22, 2019 at 4:21 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> It might make life easier for other kernel developers if "features"
> was named "compat_features" and "requirements" were named
> "incompat_features", just because of the long-standing use of that in
> ext2, ext3, ext4, ocfs2, etc.  But that naming scheme really is a
> legacy of ext2 and its descendents, and there's no real reason why it
> has to be that way on other file systems.

Yes, the naming confused me a little. :-)

-- 
Thanks,
//richard
