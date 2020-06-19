Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1890201DFA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 00:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgFSWX7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 18:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729229AbgFSWX7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 18:23:59 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D93C06174E;
        Fri, 19 Jun 2020 15:23:59 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b4so10456929qkn.11;
        Fri, 19 Jun 2020 15:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=145gDxPs4UjYBcZ4oStF0WngBWodlGruxxsqd7FuCUg=;
        b=Kk6pcx/vpw5c9Vm519/nmC7IlCQ5PEgq77a4uNMJGFxHMnh81Y5hPAZ3kOKOXBblvC
         4kxQp4oHPCFH7vgM8ziZkSyRmBMOV1DHRoES6At3qq3L1qqTcuAjwLmQj/maA1U1GOLJ
         0vIkEluNxZw05LAYudI9dv9VTQFnKfMoa/cfUokbxNz6QAJWpdyr8BcUYHiL6qXZmoD2
         rk5Cjvq7JyAGTPwJALA6zpwtU8zyxYAJJ8U+7cbONSRLMQy1X+Q6cLUlrUAv+8cKDYbO
         NP0xyF4452zygPMvuiqsfwgb21qKLDs/7QT8mqXscjNpQ3OSNP/WSwmzRCOhcVHpY74U
         AUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=145gDxPs4UjYBcZ4oStF0WngBWodlGruxxsqd7FuCUg=;
        b=VLyw5VqV0IDOzCw+1vVb55W/NdbVZaUYUjUJvk9lOOz0gNOhiFZZCshSycu0YaA/Yh
         GolO10m+IOHH8vKSzbKQInx5zyjr6HYTHfxHafu2ySu2jK2n/Ylz54aTkdk3aunSj33q
         D4sIn/9UlyBiONu7RNOLtMkBwrkS4T816Vd0qCTS+hxun/WexToyoTskDBPNsR2NvZiu
         aMUqI1OMYQ41L5uSaa83kSwlt+OZ0R5Th+OUzjlFKaopvmCnfyarTJkjegtwa0/46kIS
         /zml2Iz2eQldOx2XsbYTWJroJbVlAZqBVya42e//wH5XJxhGl/FshifC69Ft934zFgrH
         CwKQ==
X-Gm-Message-State: AOAM532Xn0SUksusMemS0p8DBTl6oCoflw6iz8ZbPyKI7Nun4ax2PSRK
        EArzCVrCUSqtXe3U3WT4RFI=
X-Google-Smtp-Source: ABdhPJxMlduq8nlFoUJ1WNTxjYcATahyZco+/QgnyHvmhYWPBmhSWSNmkIKbLWhVUjx4HWOpGO34ng==
X-Received: by 2002:a37:5805:: with SMTP id m5mr5773473qkb.176.1592605438317;
        Fri, 19 Jun 2020 15:23:58 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id g51sm7850276qtb.69.2020.06.19.15.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 15:23:57 -0700 (PDT)
Date:   Fri, 19 Jun 2020 18:23:56 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Rick Lindsley <ricklind@linux.vnet.ibm.com>
Cc:     Ian Kent <raven@themaw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
Message-ID: <20200619222356.GA13061@mtj.duckdns.org>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
 <20200619153833.GA5749@mtj.thefacebook.com>
 <16d9d5aa-a996-d41d-cbff-9a5937863893@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16d9d5aa-a996-d41d-cbff-9a5937863893@linux.vnet.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 19, 2020 at 01:41:39PM -0700, Rick Lindsley wrote:
> On 6/19/20 8:38 AM, Tejun Heo wrote:
> 
> > I don't have strong objections to the series but the rationales don't seem
> > particularly strong. It's solving a suspected problem but only half way. It
> > isn't clear whether this can be the long term solution for the problem
> > machine and whether it will benefit anyone else in a meaningful way either.
> 
> I don't understand your statement about solving the problem halfway. Could
> you elaborate?

Spending 5 minutes during boot creating sysfs objects doesn't seem like a
particularly good solution and I don't know whether anyone else would
experience similar issues. Again, not necessarily against improving the
scalability of kernfs code but the use case seems a bit out there.

> > I think Greg already asked this but how are the 100,000+ memory objects
> > used? Is that justified in the first place?
> 
> They are used for hotplugging and partitioning memory. The size of the
> segments (and thus the number of them) is dictated by the underlying
> hardware.

This sounds so bad. There gotta be a better interface for that, right?

Thanks.

-- 
tejun
