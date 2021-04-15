Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E9036121B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Apr 2021 20:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbhDOS3f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 14:29:35 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:44667 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbhDOS3f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:29:35 -0400
Received: by mail-pg1-f169.google.com with SMTP id y32so17471033pga.11;
        Thu, 15 Apr 2021 11:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TV0W0PA+E/xRpJBeBsTztONxJa8elueaRo6voPq/Bf4=;
        b=BMznXrFvmF7Gy3DUUis+2tGlzSuPo1FJVgELNPI5OEQ7OfFLFsT33pMLTmOHYaE9j/
         NgUtfcH4089DyHcOuRf8haPFLzJWneQnKaEbcMzpCBn+BQROYISSONUHK1Mlin+9jgnN
         d7pgbcycscdATxDjsUjZmcWmgqJbNaIuvd277O0631wS2FfnEM/U+gA5bQpFv6n757fj
         eam4rFLYDaOowuMlIoJ2CJr26tB4ePOXpvjHmyJn3KD5P9+75LBrVzyOi975xxGMhKHv
         IttFsjbsGnJ5M41/Vz3a6xzn9kg3FiO42ZzH3OuULHVnripFowWlFEvg5iAgjc/fb+LI
         9yXw==
X-Gm-Message-State: AOAM531mlZhfYMNN88LTqR448GupQoGq/Iye7/nrspEGPtQIr4TNL2IA
        C8xM5pPyTp7XljSVt6v0QFA=
X-Google-Smtp-Source: ABdhPJzIwpv7qrR++Yme2wzTD+E6VL3I4NlABqPKtNImJyDg0nHQaQ2z18qPL/uAt8D1W1eCM+32iw==
X-Received: by 2002:a63:3244:: with SMTP id y65mr4766094pgy.197.1618511351614;
        Thu, 15 Apr 2021 11:29:11 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id c9sm2748735pfo.122.2021.04.15.11.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 11:29:10 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id CBD5740402; Thu, 15 Apr 2021 18:29:09 +0000 (UTC)
Date:   Thu, 15 Apr 2021 18:29:09 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Filipe Manana <fdmanana@suse.com>, David Sterba <dsterba@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@fb.com>,
        Josef Bacik <jbacik@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Mahoney <jeffm@suse.com>
Subject: Re: [RFC v3 0/2] vfs / btrfs: add support for ustat()
Message-ID: <20210415182909.GK4332@42.do-not-panic.com>
References: <1408071538-14354-1-git-send-email-mcgrof@do-not-panic.com>
 <20140815092950.GZ18016@ZenIV.linux.org.uk>
 <c3b0feac-327c-15db-02c1-4a25639540e4@suse.com>
 <CAB=NE6X2-mbZwVFnKUwjRmTGp3auZFHQXJ1h_YTJ2driUeoR+A@mail.gmail.com>
 <e7e867b8-b57a-7eb2-2432-1627bd3a88fb@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7e867b8-b57a-7eb2-2432-1627bd3a88fb@toxicpanda.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 15, 2021 at 02:17:58PM -0400, Josef Bacik wrote:
> There's a lot of larger things that need to
> be addressed in general to support the volume approach inside file systems
> that is going to require a lot of work inside of VFS.  If you feel like
> tackling that work and then wiring up btrfs by all means have at it, but I'm
> not seeing a urgent need to address this.  Thanks,

That's precisely what I what I want to hear me about. Things like this.
Would btrfs be the ony user of volumes inside filesystem? Jeff had
mentioned before this could also allow namespaces per volumes, and this
might be a desirable feature.

What else?

 Luis
