Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8775A18D20
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 17:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfEIPkF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 11:40:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33499 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfEIPkF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 11:40:05 -0400
Received: by mail-ot1-f67.google.com with SMTP id 66so2729736otq.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 May 2019 08:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xSzZV65JqCtXVXp3jlprv98tNwKpdM2hfn5arWFOHlQ=;
        b=Wj8IycJkrri//lG167IMCLkpOF3P0RDxUTLSG3qf9PCTxjX6DB+bZDqLo2GKXYpIUf
         94bR8IgO7nRPbkGSFYZHQVN0lU1j6cz8KrLDPTP3KwkFZqctJwA+D8F2qyn16FimrDmH
         H5jjZi+ZDGieYHHhmUB29OScA2PIGo+DMzXF9jd/7XwemUkPWQKR1VryhTn6yT2eolZ6
         QONFr619BXzyo+BPB4fPNS3KtX6h31ZRXuc1elagjPwt9M1Flreeam4G5G5vfbKRfSfy
         Y+8ExhrjY6/TcnA9Fg9D4UQN9M0PcpY0mWTlGB3qfPw1Cq57BSZNqHdPIkJm3mV1j2T+
         Tg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xSzZV65JqCtXVXp3jlprv98tNwKpdM2hfn5arWFOHlQ=;
        b=tB8obAXLwsuEEK8kRvI7TH70ETveYhZvMmsABS4RCbdZzyZ9HyO1QpQ+MYvvI+yvDw
         qwvJrfReFfwtkuACp4fcFz2lnk+y+02jAC1T33oXxQa2rayIOO4brVaEKadawy9LjwrH
         OuzuIYsuXA9oJlVa5gtBho5iqP6drXiPQaSPDZIGepIHRdEuadSOHEBU2KpRWYh1anJY
         bPgHepQ0y3Lgba86bdLkztLCjtKf1WnRJ8GXaIMnpp7xXG9ZtonCCkdAsdTCJH2BM+4w
         HWZCqjxUYD3lTgn9rTXlno8ulc5ELKDg/1g3KfJbsNkX4p9zbqhz8XYn52HvYl8Uq/UH
         j7Xw==
X-Gm-Message-State: APjAAAWcTIlZJTtHhovv/Cj1cmwgomnrzxG2BCgaYGSpiwSGX6/KR6/A
        hcThTAKG07o2RsGxxMAKaFiQKg==
X-Google-Smtp-Source: APXvYqzhrR/B1Ofdn+/XkOJi4J9l1K72xcXghvK7Q4wTyN1HvQcy2LB9NlYNQ6igJr8sgEA2B0kobw==
X-Received: by 2002:a9d:826:: with SMTP id 35mr3067127oty.114.1557416404417;
        Thu, 09 May 2019 08:40:04 -0700 (PDT)
Received: from brauner.io ([172.56.6.91])
        by smtp.gmail.com with ESMTPSA id c131sm949673oif.33.2019.05.09.08.40.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 09 May 2019 08:40:03 -0700 (PDT)
Date:   Thu, 9 May 2019 17:39:59 +0200
From:   Christian Brauner <christian@brauner.io>
To:     viro@zeniv.linux.org.uk, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] fsopen: use square brackets around "fscontext"
Message-ID: <20190509153957.ahqqxwzipdvjxudo@brauner.io>
References: <20190508152509.13336-1-christian@brauner.io>
 <20190508152509.13336-2-christian@brauner.io>
 <20190509153902.tqkoooxtviafrla5@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509153902.tqkoooxtviafrla5@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 09, 2019 at 05:39:02PM +0200, Christian Brauner wrote:
> On Wed, May 08, 2019 at 05:25:09PM +0200, Christian Brauner wrote:
> > Make the name of the anon inode fd "[fscontext]" instead of "fscontext".
> > This is minor but most core-kernel anon inode fds carry square brackets
> > around their name (cf. [1]). For the sake of consistency lets do the same
> 
> This "(cf. [1])" reference was supposed to point to the list below. But
> since I rewrote the paragraph it can simply be dropped.  Sorry for the
> oversight.

I'll resend with the commit message fixed up.

Christian
