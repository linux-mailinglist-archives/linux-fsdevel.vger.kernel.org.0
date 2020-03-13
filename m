Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFE6185258
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 00:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgCMXbN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 19:31:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37133 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgCMXbM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:31:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id a32so5046032pga.4;
        Fri, 13 Mar 2020 16:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oyyH9y0AI663YPaE5L129siQ7RkOUafSORjt+ZnyGXQ=;
        b=dh7xSmb4iyWmxUSwA11lLKt+pyeOxvgqrQG8pnefmMaPtArECklVLDlMBCaMqv/j+p
         aIH2Vf6kE9PRpgXIwfXHQFZLZjXqbrgYWVgwHbi5V4GMChRZxCPmwiRijWRFG3iIhZTB
         A16voCzmYmKWbX3ARmPDdXLxMHzWxvSYnswiCdiQvf8+41Y03JRumKFRP410wZBNSTEQ
         eSfcZhGmx//N0XWHBPxVJuJAi/ADC44tCqrtXDiUC30apoNNHWq7hUODLn+US9CSaSiu
         mqwLM4zaQACZpHY+gTWKAu9cUxafcXccq4jHI4j78bjPJ8XF6e6MKy8FQgIlxILS7Rar
         355Q==
X-Gm-Message-State: ANhLgQ1Z5uwpVrvDkQfXCE0YR/I/sv46uxJurbPnnVktZvyijIjsCuok
        0o2jShXBBuCdjlgjDXgKftYuU3MI4RU=
X-Google-Smtp-Source: ADFU+vvPjs6bYLjsytHj0bkKsqPhHzQWid+Yfr7V1g4AOkc/IfEfW2SJhKJ7rc8E3bUlM2770XbiRQ==
X-Received: by 2002:a63:4e01:: with SMTP id c1mr14862172pgb.435.1584142271430;
        Fri, 13 Mar 2020 16:31:11 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id q6sm11153325pja.34.2020.03.13.16.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 16:31:09 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 32AC4404B0; Fri, 13 Mar 2020 23:31:09 +0000 (UTC)
Date:   Fri, 13 Mar 2020 23:31:09 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     NeilBrown <neilb@suse.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>, NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v2 3/4] docs: admin-guide: document the kernel.modprobe
 sysctl
Message-ID: <20200313233109.GV11244@42.do-not-panic.com>
References: <20200312202552.241885-1-ebiggers@kernel.org>
 <20200312202552.241885-4-ebiggers@kernel.org>
 <87lfo5telq.fsf@notabene.neil.brown.name>
 <20200313010727.GT11244@42.do-not-panic.com>
 <20200313190529.GB55327@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313190529.GB55327@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 13, 2020 at 12:05:29PM -0700, Eric Biggers wrote:
> Let's just write instead:
> 
> 	For example, if userspace passes an unknown filesystem type to mount(),
> 	then the kernel will automatically request the corresponding filesystem
> 	module by executing this usermode helper.  This usermode helper should
> 	insert the needed module into the kernel.

Works with me.

  Luis
