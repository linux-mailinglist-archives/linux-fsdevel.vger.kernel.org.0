Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71B4A152F7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2019 19:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfEFRoI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 May 2019 13:44:08 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:32813 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfEFRoI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 May 2019 13:44:08 -0400
Received: by mail-vs1-f66.google.com with SMTP id z145so8675922vsc.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2019 10:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OeGgjZBJ9uWD1pdsX/+zOfgOjAibZGBp9WPaU0eToUc=;
        b=m4Zw2fBY+VMLzhBfTBbz4Dtlq0Cc6l6MqEwoJ7YTjrYPzeO8QeIYW3yIFLyCL117Kt
         axxocOSPh/a+gWkz5TWdPKqb2BPRt/jtybJOfLKxxemlLxpId3LZKDrEsHYJlkXqRfwz
         fCTrKPtDSaBjY4auU4otyGauXVMtlpMTLmviNmwp8xF+tgZuQMZPsaKxN5HR6oBL5vv2
         Zb040i1FzkyXpGkN4I4IP7WFVE6iEZwE10S2R1vSIzVYWL40r/PqrLJElx8kQUpZMdyS
         9343jPbZPHbXIDd2SJlyBmLnUf59HZ8PtlBE/IOAyuF/EUfnmI/1F3+fvCafLr94a9B9
         gs7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OeGgjZBJ9uWD1pdsX/+zOfgOjAibZGBp9WPaU0eToUc=;
        b=KtY5l3pFt9h0nblQN3t4kW+K41R2r/cFO2rJ+N5hfMp6WtEW3QhD50JNH/5ERa1X2E
         p4YaIMKzyzxuuJ7JNDxgLL06DvQ2kD535hUNDvEW8Y4OZDTT65qfIT11N/wM5n/MWKlO
         GRRPEujjZsVbA8ZagWE5JEVCort+L4qHVnfgnePigY0cqHHQBqOFWJ+cyrjNHXVxWnSz
         ndCmleqSUD0Fw3MTBvrCWes51I75yV0d6HDLaXJMBsL52FPA7AgbQxqIRgltiVMNvgDk
         1kqhcqZrRq4FjBlHp1AZNIFK1WfRUehrrJkYmU99CKvwIK9HR4hA2Jtnlghodpcq6qdC
         w3fA==
X-Gm-Message-State: APjAAAXDT7CrxJkZMlPCexkPSD1lklrs0yaJI2Tvif7PoDHfFlRSiWYE
        YlL6vTEgXwLfR+4V4qGDfa8jgAvkZTfTghxoUqmtfw==
X-Google-Smtp-Source: APXvYqxj9ho/3KigVFISlPQqfamyJ4vl1xCgP8i9j8q0ibA/ApDLHmmjNXKUf72ouvJJD/44drdXvLamKur++kGc2Rs=
X-Received: by 2002:a67:dd95:: with SMTP id i21mr8883021vsk.48.1557164647231;
 Mon, 06 May 2019 10:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-13-brendanhiggins@google.com> <20190502110220.GD12416@kroah.com>
 <CAFd5g47t=EdLKFCT=CnPkrM2z0nDVo24Gz4j0VxFOJbARP37Lg@mail.gmail.com>
 <a49c5088-a821-210c-66de-f422536f5b01@gmail.com> <CAFd5g44iWRchQKdJYtjRtPY6e-6e0eXpKXXsx5Ooi6sWE474KA@mail.gmail.com>
 <1a5f3c44-9fa9-d423-66bf-45255a90c468@gmail.com> <CAFd5g45RYm+zfdJXnyp2KZZH5ojfOzy++aq+4zBeE5VDu6WgEw@mail.gmail.com>
 <052fa196-4ea9-8384-79b7-fe6bacc0ee82@gmail.com> <CAFd5g47aY-CL+d7DfiyTidY4aAVY+eg1TM1UJ4nYqKSfHOi-0w@mail.gmail.com>
 <63f63c7c-6185-5e64-b338-6a5e7fb9e27c@gmail.com>
In-Reply-To: <63f63c7c-6185-5e64-b338-6a5e7fb9e27c@gmail.com>
From:   Kees Cook <keescook@google.com>
Date:   Mon, 6 May 2019 10:43:55 -0700
Message-ID: <CAGXu5jJpp2HyEWMtAde+VUt=9ni3HRu69NM4rUQJu4kBrnx9Kw@mail.gmail.com>
Subject: Re: [PATCH v2 12/17] kunit: tool: add Python wrappers for running
 KUnit tests
To:     Frank Rowand <frowand.list@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
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

On Sun, May 5, 2019 at 5:19 PM Frank Rowand <frowand.list@gmail.com> wrote:
> You can see the full version 14 document in the submitter's repo:
>
>   $ git clone https://github.com/isaacs/testanything.github.io.git
>   $ cd testanything.github.io
>   $ git checkout tap14
>   $ ls tap-version-14-specification.md
>
> My understanding is the the version 14 specification is not trying to
> add new features, but instead capture what is already implemented in
> the wild.

Oh! I didn't know about the work on TAP 14. I'll go read through this.

> > ## Here is what I propose for this patchset:
> >
> >  - Print out test number range at the beginning of each test suite.
> >  - Print out log lines as soon as they happen as diagnostics.
> >  - Print out the lines that state whether a test passes or fails as a
> > ok/not ok line.
> >
> > This would be technically conforming with TAP13 and is consistent with
> > what some kselftests have done.

This is what I fixed kselftest to actually do (it wasn't doing correct
TAP13), and Shuah is testing the series now:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=ksft-tap-refactor

I'll go read TAP 14 now...

-- 
Kees Cook
