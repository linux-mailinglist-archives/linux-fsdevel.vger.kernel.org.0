Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7797A55E3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 04:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfFZCTz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 22:19:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40775 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFZCTz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 22:19:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so385423pgj.7;
        Tue, 25 Jun 2019 19:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ImbOmbqru+Yum9wVwWkpBNaUFJnZhA+Sv2EnuogBtJ8=;
        b=pjd3EmA/SgbJkLY0T4kf0sILY1MilxTH2gxd25xyacQiuehXVNOCvVUQHkT8v2oshV
         F8f0MNSb9iCWMg5LzQ+U8aAVUT7pLL9A7NHEPl69WRMYjrD3rzf8b9QbEZfauVv3fFBQ
         +za5+45e4XGz/KmqIRB8/hoJTjlAwnbHJ0YAjA2OFkwe94u3gATZJv7Fl6uI8aS6pxgN
         XocbDRTHUZRnSj7JeazeWsU8ZPnUlIkgka7XnPUPMUvJEqUaTwc1a0MPZo5zkpU1+nty
         ePUhQLtM9BaeMvxrzOxHUPL8laopiaWoRbeTgFk2KKCEdrMqwX91a+zu/QW5Grgb7cbN
         O3Ag==
X-Gm-Message-State: APjAAAXkntHcst0oOXh1jeAG4iDLmB36FLKYnIwr51P+QziQRAfU/joW
        kF7B94wEXB6iZD8T/Hna+aI=
X-Google-Smtp-Source: APXvYqz/ak3oqhDInPfCtSC5xTrl5WLmu4WvNmi0OnSYEvLdryLAAJJtmF40zvlfJnfwrjGTHOLxzA==
X-Received: by 2002:a17:90a:2486:: with SMTP id i6mr1267695pje.125.1561515594542;
        Tue, 25 Jun 2019 19:19:54 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id q1sm23369013pfn.178.2019.06.25.19.19.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 19:19:53 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id BB23740336; Wed, 26 Jun 2019 02:19:52 +0000 (UTC)
Date:   Wed, 26 Jun 2019 02:19:52 +0000
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
Subject: Re: [PATCH v5 18/18] MAINTAINERS: add proc sysctl KUnit test to PROC
 SYSCTL section
Message-ID: <20190626021952.GV19023@42.do-not-panic.com>
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-19-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617082613.109131-19-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 17, 2019 at 01:26:13AM -0700, Brendan Higgins wrote:
> Add entry for the new proc sysctl KUnit test to the PROC SYSCTL section.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
