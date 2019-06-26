Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFE2D56CD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 16:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbfFZOug (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 10:50:36 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45683 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfFZOug (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 10:50:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id a14so3718609edv.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2019 07:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xn5/sjr2SkMR21Q+6SAo5VDqXrDegQPvyCLgGPTTURs=;
        b=CoKaEc3wxeHdnMcIofwNS4wPiIsB4YJ0MdREl3n8yGAalh9nxwnCt6s4C7YfqB8J7E
         XZ9CeglN7DhsaHQPGmJ83Xl5B0+DGakBv2quoUi0orpESnYwIZqHJZM9JPLeH4wUZJuZ
         FJg5EF2YLZN5kH2gFq0nfo1K9QphlQ+THUqGo+zpGmjyVGQo59izd65NQ8XrSHqXsJkV
         r+kff83JiIWKJr7BCUU9RQqkV3uJayYQQaUfcPpzsf6Svs9Nf5b9ApGUsLLNm6A7nuXq
         SEJyHZREjdICZ1ASaILln/JIbacf7oWT3YEAa3Gen4dxnBfWB6NHRmCJOP/+w/8WQDYR
         rETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xn5/sjr2SkMR21Q+6SAo5VDqXrDegQPvyCLgGPTTURs=;
        b=KuQ6vCMo89EE1YmkUrHxw9sxnIy12byQqrmzrZFyljB4B78yVzXjGqecLw0M9bQ6cf
         7NEyIQetRj1sZqCP7ch3UTgIg+Ie6G/s7OdVTQho+qyB4Sjo6xaYueP1SnWLSDepmm/Z
         uTJqcl+G2njdqykNuYYoM1fm7y5D25IN5xfppJsYBFDCoibyurw+mP1puCD7n9HFrmiN
         Fpq8AHocewIJDDUG+wH5giIV4UeRNPjlxVGofqhzrB4V0N97KSOWMesL51gc1Bz8fcll
         QQNNS4lVHs+tex+YM7eicB79+OWRsibcW4qH+xCN8SWCYsWrNLuOEgvErRAZ18WALFiI
         unbA==
X-Gm-Message-State: APjAAAWF32nBd+YSE2sSJtsYC8IAjvUpekVhqBo28VWT9f7EhZYNA9VC
        MY+WL+PvC4IWTkmdMEbGq0xq1oEHPUzYtA==
X-Google-Smtp-Source: APXvYqxihuTlAVHp7Dtm+OQSgaT0vicToPsHIUlp7ShmYxpuuMQHg3Wi0UPDnVnoRgF96oLtm3CiGQ==
X-Received: by 2002:a17:906:7f16:: with SMTP id d22mr4466398ejr.17.1561560634310;
        Wed, 26 Jun 2019 07:50:34 -0700 (PDT)
Received: from brauner.io (cable-89-16-153-196.cust.telecolumbus.net. [89.16.153.196])
        by smtp.gmail.com with ESMTPSA id a6sm5477457eds.19.2019.06.26.07.50.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 07:50:33 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:50:32 +0200
From:   Christian Brauner <christian@brauner.io>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/25] VFS: Introduce filesystem information query
 syscall [ver #14]
Message-ID: <20190626145031.nvpekusplnt5kqw5@brauner.io>
References: <20190626131902.6xat2ab65arc62td@brauner.io>
 <156138532485.25627.7459410522109581052.stgit@warthog.procyon.org.uk>
 <20190626100525.irdehd24jowz5f75@brauner.io>
 <9360.1561559497@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9360.1561559497@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 26, 2019 at 03:31:37PM +0100, David Howells wrote:
> Christian Brauner <christian@brauner.io> wrote:
> 
> > And I also very much recommend to remove any potential cross-dependency
> > between the fsinfo() and the notification patchset.
> 
> The problem with that is that to make the notification patchset useful for
> mount notifications, you need some information that you would obtain through
> fsinfo().

But would it really be that bad if you'd just land fsinfo() and then
focus on the notification stuff. This very much rather looks like a
timing issue than a conceptual one, i.e. you could very much just push
fsinfo() and leave the notification stuff alone until that is done.

Once fsinfo() has landed you can then go on to put additional bits you
need from or for fsinfo() for the notification patchset in there. Seems
you have at least sketched both APIs sufficiently that you know what you
need to look out for to not cause any regressions later on when you need
to expand them.

Christian
