Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8E1121AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 20:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfEBSI1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 14:08:27 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46497 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfEBSIX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 14:08:23 -0400
Received: by mail-ot1-f66.google.com with SMTP id 77so2914958otu.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2019 11:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=79fGKeHlH9FAaVSR1O2RxcfKwTsSnTq5QCRHjsEaUQU=;
        b=p6+GkF2pa0r8kIFWr3Ue5xSJ4hl91lXS3nyMKkOj5gQv9nBUeqd4BeLUxnZv1anIlK
         lg1rsW/DG5+gG35Q6B+ZLV3xvGi60oYqbQR6qqrpeA01srJDWSHy+u56ea2PsXrn8x+q
         dAZDe0q27TZ76u7UainpJzKpuJcdKWXXDrVVYsacHOUkrblZnv39zmUQ3mgKo/PyMxtj
         cBGYHB2uWwE8NxbLX7q9WWmg2lFe3RBeI4j2lZBmhh5c2j8csXxGrExgKmjwwY08DAy9
         PMxuPc1keMhPOI13z500WCy1D+qUSgNiYEXKQhnXWgZ+09G9ndEGtieagtsVwWkzEqOt
         uIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=79fGKeHlH9FAaVSR1O2RxcfKwTsSnTq5QCRHjsEaUQU=;
        b=CBXDLCDtVhktCrbIT45LhZgKcjNUTPq3A6YPyYdz7RT80MpI8UAZO17berp0zZP5r4
         NzJ0m626WYA2+3xbKxyOvh7VZJ+HjZHPE2Y51XVcXslNjz92YQEz1gXXhDSxPJHLuqdH
         3mA/DBhMlXnN8FFQRPICZXc/qa5LOHuxFCs4DIoiQ/SHW7TpNQd02CwBQb6Z+UN8dAQR
         lpzd+bty6mix+Rnvkmh6HJhseTv5WRZ6blh5gXg3yg6weuz3aDM8hNr6k7W2xEAhZyrU
         aZwgh16ZIwUz/SZWz/ERZVJKbthgA6Tl0yO+mkHskOe7Sb7rreJw/h7iyV52fM12LtuJ
         pmcw==
X-Gm-Message-State: APjAAAWhIvtabiLO3dUrivqpIz8DWv4HLD5wHmX9Ek1713nelvNUs6X+
        pPTO0k4P05nizL7IBQBkckccVzrgzhxQtMAuP3HRAQ==
X-Google-Smtp-Source: APXvYqw/nI7b+z83V0GIDl0oQazXtqsfs+CMRGbHgYqDLdBGzPB7zXqfHkbXMcNZ2dozl9lGwjO1NMDSJQAOJdRu1uE=
X-Received: by 2002:a9d:3621:: with SMTP id w30mr3409606otb.98.1556820502021;
 Thu, 02 May 2019 11:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-13-brendanhiggins@google.com> <20190502110220.GD12416@kroah.com>
In-Reply-To: <20190502110220.GD12416@kroah.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 2 May 2019 11:07:57 -0700
Message-ID: <CAFd5g47t=EdLKFCT=CnPkrM2z0nDVo24Gz4j0VxFOJbARP37Lg@mail.gmail.com>
Subject: Re: [PATCH v2 12/17] kunit: tool: add Python wrappers for running
 KUnit tests
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        shuah@kernel.org, devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com,
        Felix Guo <felixguoxiuping@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 2, 2019 at 4:02 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 01, 2019 at 04:01:21PM -0700, Brendan Higgins wrote:
> > From: Felix Guo <felixguoxiuping@gmail.com>
> >
> > The ultimate goal is to create minimal isolated test binaries; in the
> > meantime we are using UML to provide the infrastructure to run tests, so
> > define an abstract way to configure and run tests that allow us to
> > change the context in which tests are built without affecting the user.
> > This also makes pretty and dynamic error reporting, and a lot of other
> > nice features easier.
> >
> > kunit_config.py:
> >   - parse .config and Kconfig files.
> >
> > kunit_kernel.py: provides helper functions to:
> >   - configure the kernel using kunitconfig.
> >   - build the kernel with the appropriate configuration.
> >   - provide function to invoke the kernel and stream the output back.
> >
> > Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>
> Ah, here's probably my answer to my previous logging format question,
> right?  What's the chance that these wrappers output stuff in a standard
> format that test-framework-tools can already parse?  :)

It should be pretty easy to do. I had some patches that pack up the
results into a serialized format for a presubmit service; it should be
pretty straightforward to take the same logic and just change the
output format.

Cheers
