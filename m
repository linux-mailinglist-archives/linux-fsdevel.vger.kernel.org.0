Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D631BCC5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 21:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbgD1TZN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 15:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728515AbgD1TZM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:25:12 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C66C03C1AC
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2020 12:25:12 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z90so18267428qtd.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2020 12:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs-cmu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vip41qUVMKBqTzEGULB2fq8TW2WA+09ehaEg4M6b7gA=;
        b=OX9cephvVUT6NSDLm2aPp0wg7GbJRFkTlOE6HtLl4AbVbrBiWitjfdPqKFn2uTTlo6
         RZZdVY5cYJ+X7nFP4U5wwIm17XpQi5lJMGdnsrRRWdXhllecGup4mn011MRDxqd3PaX1
         pXXo7vzr8OqmVOdwIAIy9lxu/ZmUvfEliPItaLNfxjqDftU0dYHi4Rqi6laIoRZoWuq6
         QUwdoT7Qegg/09sur7Wia9CP4DHAidc5klwQee/5ecVGpPPKoPvyQ94BuQk8ERNSDOBw
         I9n2PPZxuM4t/KRY1hbRe5t/i6EWjpMK7w0MzwXDgyzGwrJciJy1oRw5ZNA/A4Ib1xiv
         Z8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=vip41qUVMKBqTzEGULB2fq8TW2WA+09ehaEg4M6b7gA=;
        b=VFGluIbe9tvb4PbjLLnhn4wNom2d8qilkTzwAZu2u6AU7NtVDZHnOLbQOdrqR/L6qu
         tqIVavIDTXKwbgRasMY1jVID1ykgkKCFRUyQ2/1bUU+AoGEj+WhPIShVFD0TRYZ0NsbE
         zGDPbPnCrsDM52nlvPHYIfocbE5pLtz3AbnRQjmCadMvaq+pFDdKUkDChNS49J9VRwjL
         9k9nZkU2CILh90o4j8QWMDqObiW8jwn0kd17eRbg2sx5Sr3VdVKRsGXbmar/QtHLhwox
         qqaq6oSpCbQCnpIHRdRDqZxXnpwydogS2O/AVzjnFUQwIY4W3CSDjUWI91+6QDqubTf3
         s4Gw==
X-Gm-Message-State: AGi0PuaZNWmomolSbvy1BIF0dcxCmCHCE1ZYYKYhOGwNK6gH1B1lSvMH
        sjoEi5s+vum7vAvYehprP5FjZg==
X-Google-Smtp-Source: APiQypIhJhTV5HGwJH/cgQxWAhYS/uXm9mZJikUijUM58zV+qHDsER/fp3y62V6/MA+IjGf4ymv/JQ==
X-Received: by 2002:ac8:1a2b:: with SMTP id v40mr30279995qtj.170.1588101910910;
        Tue, 28 Apr 2020 12:25:10 -0700 (PDT)
Received: from cs.cmu.edu (tunnel29655-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:582::2])
        by smtp.gmail.com with ESMTPSA id y9sm14261631qkb.41.2020.04.28.12.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 12:25:10 -0700 (PDT)
Date:   Tue, 28 Apr 2020 15:25:07 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-xfs@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 00/29] Convert files to ReST - part 2
Message-ID: <20200428192317.7h5d2wiqmy7y473r@cs.cmu.edu>
Mail-Followup-To: Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-xfs@vger.kernel.org, linux-usb@vger.kernel.org
References: <cover.1588021877.git.mchehab+huawei@kernel.org>
 <20200428130128.22c4b973@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428130128.22c4b973@lwn.net>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 03:09:51PM -0400, Jonathan Corbet wrote:
> So I'm happy to merge this set, but there is one thing that worries me a
> bit... 
> 
> >  fs/coda/Kconfig                               |    2 +-
> 
> I'd feel a bit better if I could get an ack or two from filesystem folks
> before I venture that far out of my own yard...what say you all?

I acked the Coda parts on the first iteration of this patch. I have no
problem with you merging them.

Jan
