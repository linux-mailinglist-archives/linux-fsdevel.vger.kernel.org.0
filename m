Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B22340AA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 17:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbhCRQuf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 12:50:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44893 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbhCRQu2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 12:50:28 -0400
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@canonical.com>)
        id 1lMvqt-0008Fp-KP
        for linux-fsdevel@vger.kernel.org; Thu, 18 Mar 2021 16:50:27 +0000
Received: by mail-ed1-f70.google.com with SMTP id h2so21434457edw.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Mar 2021 09:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nI/HK/aZiw2vFmpQW7WXqgLR8ZA4MRBAnT3xFXPYJvY=;
        b=TmoGJ7UMFl1T3wrgrimS9iEtTLsQBKmV+FZoteO6QFZvAaw0LQriutTerOQRit3sMr
         5a0rYYH6KEebt5q9TvaMWFrDDuj+dzIbrHVb3aTW2DKlfwqHnEn+EL8A439PQ4kiDTRp
         EFGoQpQNLYic0nFR4qiVfX7J+ZAysSyZPmTtqTuo3FiZMEeqeqj7tPdjc0IQKhXMokM1
         kGLHllpRazDdgirYSGeJA/7kXXIe2Pu0hcW9pPcgiPhJ4JHNHGDsYOWvsmA+NsXlJ2qS
         rGXrRYg57OYaIXdtqI0qrfdRCjk31l8P2QfrIhsFyeWyeUi7Q1z9KjGxr/JPsUnczyMq
         lBTg==
X-Gm-Message-State: AOAM53398MASMNrhk9pB/tucp6sii5EfQST5aHJ/mpPmeyyTLGeQngjJ
        icgs5eLcZqOmIXLBAlQI7tzl9BYz6M8aZqgkO4blYK57AISFYo+5USTN9rB0mluH+vp4FNEWLo5
        /NeF8YsUQvIO9+MpeGcLhGW/GCE6H2EUL8lu0HWeQdio=
X-Received: by 2002:a17:907:7785:: with SMTP id ky5mr30156330ejc.133.1616086227303;
        Thu, 18 Mar 2021 09:50:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyoS4Ti12fWMuNJAcdVQigMxK1LzeM53WUAy30CtNftdFq6ca6eUEX5JvR4oEtxdOB/4ElZw==
X-Received: by 2002:a17:907:7785:: with SMTP id ky5mr30156316ejc.133.1616086227110;
        Thu, 18 Mar 2021 09:50:27 -0700 (PDT)
Received: from gmail.com (ip5f5af0a0.dynamic.kabel-deutschland.de. [95.90.240.160])
        by smtp.gmail.com with ESMTPSA id s20sm2279251ejj.38.2021.03.18.09.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 09:50:26 -0700 (PDT)
Date:   Thu, 18 Mar 2021 17:50:25 +0100
From:   Christian Brauner <christian.brauner@canonical.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Xiaofeng Cao <cxfcosmos@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaofeng Cao <caoxiaofeng@yulong.com>
Subject: Re: [PATCH] fs/dcache: fix typos and sentence disorder
Message-ID: <20210318165025.qquejvrcgwfyrrfg@gmail.com>
References: <20210318143153.13455-1-caoxiaofeng@yulong.com>
 <20210318150020.GP3420@casper.infradead.org>
 <YFOBVg8UiQh4Z4II@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YFOBVg8UiQh4Z4II@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 18, 2021 at 04:35:34PM +0000, Al Viro wrote:
> On Thu, Mar 18, 2021 at 03:00:20PM +0000, Matthew Wilcox wrote:
> > On Thu, Mar 18, 2021 at 10:31:53PM +0800, Xiaofeng Cao wrote:
> > > change 'sould' to 'should'
> > > change 'colocated' to 'collocated'
> > 
> > uh.  collocated is incorrect.  colocated is correct.
> > https://www.merriam-webster.com/dictionary/colocate
> > https://www.merriam-webster.com/dictionary/collocate
> 
> A bit more condensed variant: these two are both derived from
> con- + loco, but have different meanings -
> 	colocated: occupying the same place
> 	collocated: sitting next to each other
> 
> In this case it's very much the former - the point of comment is that
> the fields in question share the same memory location, but we are
> guaranteed that any dentry we find in the alias list of an inode will
> have that location used for ->i_dentry.
> 
> "co-located" would probably work better there.
> 
> PS: history of that word pair is amusing.  Both are (English) past participles,
> of co-locate and collocate resp.  The former had the (Latin) prefix applied in
> English to borrowing from Latin (co-locate < locate < locatus) , the latter
> is straight borrowing (collocate < collocatus).  Incidentally, in both cases
> the borrowed form had already been a past participle (of loco and
> colloco) resp.  And colloco had the same prefix (com-/con-/co-) applied
> in Latin, with regular assimilation of -nl- to -ll-.  But at that stage
> the meaning of the verb had been closer to "put in place" than to
> "be in place", so that gave "put next to each other" instead of "share
> the place".  Shift towards "be found next to each other" happened long after
> the prefix had been applied...

(Flashback to my latin exams. The only thing that is missing is
complete confusion about nested subordinate clauses... ;))
