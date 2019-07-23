Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF7A97227E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2019 00:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbfGWWgZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jul 2019 18:36:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45533 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfGWWgZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jul 2019 18:36:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id r1so19838439pfq.12;
        Tue, 23 Jul 2019 15:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zNouKbF6UyPadfEdFSK5fRF7G6CWHnxRN1FzAl+dNYs=;
        b=SdQIiqD4fkEQwr9X83RCA6yuwNBY1uChpKnXh3cAh+UZV7T/q90T66/ebWnSWzMdU1
         4ZhW4dn/MufMU2L+7JiJDj0tARsd7/JfDcK7Kqqk3vaKGtlGIJNFTFOKuIVEJ0tJg6HV
         nJBlNrJlbG4z+e88LPyvn8BrL/xxUJQuiugCiM1POSvapwm84nYrkEXh/Mp5F/0QCKHD
         T4d7iSWVbnhNQvkYjTIxXZMgF9DK7sKqcgjD1ReNDbfobnDjlowVaYpWEDPDMZN2xhW7
         pis75BozdMnhMsLgEScEd3kHzIXXtW8zbGK+ErLn5nFgdmWdRJBTzk0v8ZxIrsyj4e4i
         052A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zNouKbF6UyPadfEdFSK5fRF7G6CWHnxRN1FzAl+dNYs=;
        b=lHezlGNQMLc06neDrlGeTu2C9jbKyLlRxOt/jlocy7Ycj217XlmUrHARZX9aeXleEW
         1kGxfVrJ7+jlTgCBw8NBQgXy0lWSseNAAnrIXIw6l512r2/0oHMOntQRWcYjKt6wfL7l
         FiSR8oMGA9qWzePUJovI8kK9fzoIS7jrBTETtXvhewGWg85ACeBb6Hl5S2EyWmiPfi+Z
         6oqdKwmCOyNWa90AtbeWArqpQ+PObcT0v2e7gu50LriO0I/VwqbvBXSDcuMK+qXwwrDN
         Vw6rVfu9kzVjR1K1qr/FM91leZgIPflK24v8Uk+a8uSNwgMJJamfya41YjTriPBW4uiB
         SnTA==
X-Gm-Message-State: APjAAAX+/XJDj4/9ssO2+FBrD/azA2l/bo2ooefm6EC1z6RC4394YTFP
        ziDYOIDV2k/saph/qSLV3LU=
X-Google-Smtp-Source: APXvYqziGHn+6jGrdziu5cLb9QnyDXXK2JmIkImwr7M2iRolvR/fyo5r25/cJX4zAbOa2Ux1/H46Dw==
X-Received: by 2002:a62:5883:: with SMTP id m125mr7941308pfb.248.1563921384228;
        Tue, 23 Jul 2019 15:36:24 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:2287])
        by smtp.gmail.com with ESMTPSA id w132sm45870833pfd.78.2019.07.23.15.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 15:36:23 -0700 (PDT)
Date:   Tue, 23 Jul 2019 15:36:21 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Konstantin Khlebnikov <koct9i@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Cgroups <cgroups@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] mm/backing-dev: show state of all bdi_writeback in
 debugfs
Message-ID: <20190723223621.GF696309@devbig004.ftw2.facebook.com>
References: <156388617236.3608.2194886130557491278.stgit@buzz>
 <20190723130729.522976a1f075d748fc946ff6@linux-foundation.org>
 <CALYGNiMw_9MKxfCxq9QsXi3PbwQMwKmLufQqUnhYdt8C+sR2rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALYGNiMw_9MKxfCxq9QsXi3PbwQMwKmLufQqUnhYdt8C+sR2rA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 24, 2019 at 12:24:41AM +0300, Konstantin Khlebnikov wrote:
> Debugging such dynamic structure with gdb is a pain.

Use drgn.  It's a lot better than hard coding these debug features
into the kernel.

  https://github.com/osandov/drgn

Thanks.

-- 
tejun
