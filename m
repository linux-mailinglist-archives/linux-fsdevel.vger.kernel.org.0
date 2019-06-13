Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE46C43BBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfFMPbJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:31:09 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36535 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbfFMLEv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 07:04:51 -0400
Received: by mail-qt1-f196.google.com with SMTP id p15so2604487qtl.3;
        Thu, 13 Jun 2019 04:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Yitzb6kjU2aLOslqgMIWbRZiABA1TAj4ngzKLKr9wE=;
        b=fCHp8RtsWnLh5ko2sLFxCylLJJXn5AyrEpNNv0SopTUgnr2jgVBnd43lKLr+xpyPpV
         h3ZQm28Vp7iGmDdvvI9KDs/FtEVKPjoYayTPJv6SxgP7fbtGk1ZdUnViHx0mgPZ1VrtL
         3dzOCvXC2fs9rqNnsSuF8v7p/31HZBR9Bdv7srVGoH+jwuvgQwGvG7GQCuU4duwtSrsW
         irx9hUAsDR2J02ekNAGu4SJw4ZsDesWc8Zw3k5FJxMh0vUyZwRICS4Pd8aXXrvv4U4wB
         dSIYKct0mX2+cXKjNsZE5YSeu+j+4JB0K8V7w8XbsOrN1wbc5MIy4U4n1UYKIcYAefmF
         OKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Yitzb6kjU2aLOslqgMIWbRZiABA1TAj4ngzKLKr9wE=;
        b=UQ8RbFoa0y2XzbqIrDNTjtEFZXowX3EsDAUWlEeNAHxmFGM977PotZK34QGQkN/GyG
         8tVdJDUUYhXYqPkUNQ/Ws2iQNN/R1qOp0Xjjm+UVgNeUf0hMoSHB/MlOP5bsqo12R0gI
         zrXKoTrpAw5PjcCWfnjKU9zfgcnoq2P62/BnOFzVoKk5RbEArvbGUFN+k++ltojrdOGo
         dD3SdnFXc9xNXSPFj6yT78AI2gVUkXAGNRTqN9NH538UcWi11BUFA/jyAUc+Yp1Yi1Ga
         kC0BetcUwPRMlc00GsqbOXUYHZQp0Fm9G5JIS3A0cEI7UBMABQk2eb1RBYp0uH5Y6qm9
         BGwQ==
X-Gm-Message-State: APjAAAUyfj0yXbjqylDSR5ApZZxMa+dZI7z2FmxSWQIYmCAGSdVDF+sD
        JLGZ46Bn9aEHOkqRUyPw3BIU5i3Qt/au
X-Google-Smtp-Source: APXvYqxKem25yu2HU3N6YOMpfWBwfrpyww3WOxCrFTPTaSBVWq0llduc4WEKaj6v7esj8r8s/NKsbw==
X-Received: by 2002:a0c:87ab:: with SMTP id 40mr2924212qvj.93.1560423890503;
        Thu, 13 Jun 2019 04:04:50 -0700 (PDT)
Received: from kmo-pixel (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id r39sm1575102qtc.87.2019.06.13.04.04.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 04:04:49 -0700 (PDT)
Date:   Thu, 13 Jun 2019 07:04:47 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcache@vger.kernel.org
Subject: Re: [PATCH 10/12] bcache: move closures to lib/
Message-ID: <20190613110447.GA15110@kmo-pixel>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <20190610191420.27007-11-kent.overstreet@gmail.com>
 <20190613072841.GA7996@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613072841.GA7996@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 13, 2019 at 12:28:41AM -0700, Christoph Hellwig wrote:
> On Mon, Jun 10, 2019 at 03:14:18PM -0400, Kent Overstreet wrote:
> > Prep work for bcachefs - being a fork of bcache it also uses closures
> 
> NAK.  This obsfucation needs to go away from bcache and not actually be
> spread further, especially not as an API with multiple users which will
> make it even harder to get rid of it.

Christoph, you've made it plenty clear how much you dislike closures in the past
but "I don't like it" is not remotely the kind of objection that is appropriate
or useful for technical discussions, and that's pretty much all you've ever
given.

If you really think that code should be gotten rid of, then maybe you should
actually _look at what they do that's not covered by other kernel
infrastructure_ and figure out something better. Otherwise... no one else seems
to care all that much about closures, and you're not actually giving any
technical feedback, so I'm not sure what you expect.
