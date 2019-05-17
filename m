Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA3C21F3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 23:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbfEQVCY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 17:02:24 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34686 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbfEQVCY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 17:02:24 -0400
Received: by mail-qt1-f195.google.com with SMTP id h1so9681064qtp.1;
        Fri, 17 May 2019 14:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zm172sKuEoJHoST/QG9QtXQuShTwFrHdaf7AbMxHV/c=;
        b=NvtUMrEEEmOmOEaikDJJe53KWEzTe30PTlqu92ySPuycej06XQWJu+rFpdk/3OJM34
         Z/nasyQM0942f/xMmRcaxJ0PTSKm40p4bsqdWHJc/dhtrVKkV/XBz4tkFW4/510XTCoV
         K3pS0Kb28WteLZqychrKFcRjSeeZYCuQ2yc8lKGwBSF2ipldMpcAU3mPTWy/z8YfooI5
         JZYYB0RprvKbpK1U/ozZ8Xsf1SgOpBVU4Dx5qfRURfzXdP5ipFf4IFpGjaAEMt8k0vfN
         g1x3FVVHhUH9xIyb9Dk5mF0c6RkhD9/NYojUcLUPiO7Wdgi2UKlxtgN42mEDPoUv9nqM
         9vWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zm172sKuEoJHoST/QG9QtXQuShTwFrHdaf7AbMxHV/c=;
        b=MGc7TQbiHmTattsGIm5LHLfHGbIhStuXA0FTM9k6uuwAU+ewqO2sfSbB9Ebj/4HNj9
         d6reKQ7ozXe/6ByT3RKfV/xXWeF+A3JRESp1TXUfnakCrIP8mzcQBj3JUna2fOoNNUYn
         IS4PMFbmlhho6o3HJBLttiP3L0MiX4XuEinpcG32czLXazSIXAGsB+F6XF+DfA+8PzUm
         Vi0nRIJLKW0mRYoWFzy2JhEU17bCa5aw4+k79J9dofM6azQ6y3aGi0IBmwPYJRnY9xi8
         5cthN0dS/J+PaVXDowVX8VdaDrAa3CCCl/U+F/j3wPuQ3llptuYP5FA92AkHI73nLFks
         fAeA==
X-Gm-Message-State: APjAAAVjBVtZpEQHOdJSX7GtbsmpjJspgQG7Yx9fyonZYDoVJR+mfJ0k
        +NyBBrzPqoRDmRdDFWXjJ/A=
X-Google-Smtp-Source: APXvYqwvttvCTTpLBiz1t71xS2G4tD7pzgpktH+Nh7koNB/WjUqUYr7Alq0vzVBtVRRRrJuXlstVSA==
X-Received: by 2002:ac8:353a:: with SMTP id y55mr48673865qtb.95.1558126942686;
        Fri, 17 May 2019 14:02:22 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id e4sm4540925qkl.17.2019.05.17.14.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 14:02:22 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 17 May 2019 17:02:20 -0400
To:     hpa@zytor.com
Cc:     Roberto Sassu <roberto.sassu@huawei.com>, viro@zeniv.linux.org.uk,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, arnd@arndb.de,
        rob@landley.net, james.w.mcmechan@gmail.com, niveditas98@gmail.com
Subject: Re: [PATCH v3 2/2] initramfs: introduce do_readxattrs()
Message-ID: <20190517210219.GA5998@rani.riverdale.lan>
References: <20190517165519.11507-1-roberto.sassu@huawei.com>
 <20190517165519.11507-3-roberto.sassu@huawei.com>
 <CD9A4F89-7CA5-4329-A06A-F8DEB87905A5@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CD9A4F89-7CA5-4329-A06A-F8DEB87905A5@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 17, 2019 at 01:18:11PM -0700, hpa@zytor.com wrote:
> 
> Ok... I just realized this does not work for a modular initramfs, composed at load time from multiple files, which is a very real problem. Should be easy enough to deal with: instead of one large file, use one companion file per source file, perhaps something like filename..xattrs (suggesting double dots to make it less likely to conflict with a "real" file.) No leading dot, as it makes it more likely that archivers will sort them before the file proper.
This version of the patch was changed from the previous one exactly to deal with this case --
it allows for the bootloader to load multiple initramfs archives, each
with its own .xattr-list file, and to have that work properly.
Could you elaborate on the issue that you see?
