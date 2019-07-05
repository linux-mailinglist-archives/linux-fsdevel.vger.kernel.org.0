Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C90C860CC9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 22:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbfGEUsN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 16:48:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33691 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbfGEUsN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 16:48:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id x15so4783636pfq.0;
        Fri, 05 Jul 2019 13:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AcnoVRibB2N6fZ+Yp6hO160ET8GdPKrkYOq4kfDG3/o=;
        b=U+A52T7uN8wFdktHUnLIZDXucd2tGsN+Yc1acydhtUhVA6g71/vXY/zPVbtz/wofy6
         +ewZk9kdrIen3fy6pacm+NXGg2uHjV6z1/Lpnc0GcZh+GwF/SMbT/6aP35WXTuFrq8Ei
         z6ND45p35bhuF4Rxhgt8Hiju2HSTHvzM5JdPcL30yPK/LZCjk4tu+61hk3aktBFBhiD0
         qMx1nibJWaDtPMH7ZlvdJkhJnGkLxRjgHw1ZAQ+JC/js3djI3Itp+zCfbgv9gR5ntp0P
         hWUT4tc05R44rTuyqFSfupf4MET8jzDwHPVRsbTBPNN1pVWfGdvj7XJASs84XG0UVx2W
         PmaA==
X-Gm-Message-State: APjAAAV2yao8D8E3u+kh2jmLTgrklxXu7dAmUETPhKApTXU0B05iM6Pq
        eGP9pQU9sEZD3UeHXjcnZSY=
X-Google-Smtp-Source: APXvYqzYFkN68Owkq9koxWESGSYcLlSN0sO/MqwSKxCi7MUUXmOztl1dSndkrgfsbD0HEg9i6sStdg==
X-Received: by 2002:a63:6986:: with SMTP id e128mr7831367pgc.220.1562359692276;
        Fri, 05 Jul 2019 13:48:12 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id p7sm13219309pfp.131.2019.07.05.13.48.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 13:48:11 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 568B940190; Fri,  5 Jul 2019 20:48:10 +0000 (UTC)
Date:   Fri, 5 Jul 2019 20:48:10 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, peterz@infradead.org,
        robh@kernel.org, sboyd@kernel.org, shuah@kernel.org, tytso@mit.edu,
        yamada.masahiro@socionext.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
        Tim.Bird@sony.com, amir73il@gmail.com, dan.carpenter@oracle.com,
        daniel@ffwll.ch, jdike@addtoit.com, joel@jms.id.au,
        julia.lawall@lip6.fr, khilman@baylibre.com, knut.omang@oracle.com,
        logang@deltatee.com, mpe@ellerman.id.au, pmladek@suse.com,
        rdunlap@infradead.org, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com
Subject: Re: [PATCH v6 18/18] MAINTAINERS: add proc sysctl KUnit test to PROC
 SYSCTL section
Message-ID: <20190705204810.GE19023@42.do-not-panic.com>
References: <20190704003615.204860-1-brendanhiggins@google.com>
 <20190704003615.204860-19-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704003615.204860-19-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 03, 2019 at 05:36:15PM -0700, Brendan Higgins wrote:
> Add entry for the new proc sysctl KUnit test to the PROC SYSCTL section.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>

Come to think of it, I'd welcome Iurii to be added as a maintainer,
with the hope Iurii would be up to review only the kunit changes. Of
course if Iurii would be up to also help review future proc changes,
even better. 3 pair of eyeballs is better than 2 pairs.

  Luis
