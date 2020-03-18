Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19BC218A576
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 22:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgCRVBj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 17:01:39 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40714 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbgCRVBj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 17:01:39 -0400
Received: by mail-ed1-f68.google.com with SMTP id a24so32676724edy.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2020 14:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h1JVSDR71Ka3PM04u0ramfobv1CKoUTWgjm5qfW2CV8=;
        b=m+CruKFqyeFiSzmQCZqiAjkeem718D1Unt4LZxrLyM48zoGD0gDaVn0NlVfCexVTzu
         wihdula0cgpJNes9gbbbPZGOCr8gmzgfMR1DP2niKlc4/Xbz1RjMvIcZK3QeYS4MTBzR
         VGVmqZmbPsEQ42JahCXbnk6yopm5byhYxfuE4bMF2/oEIwfi0TIGwhWzo+tUFEv5Mobg
         xAZqhXW9ZYNPl8K7ISeE3z29hhnh0uDlXFQhZXWxMxod1HlKG5GyxdS8a7Q7I9YuWv4C
         hEdfpxYwsjziy7uL5etvx6svflsV0+OWDJH1g09o69UnURs0B4B8khAkiIXSB+T2BP9R
         8WWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h1JVSDR71Ka3PM04u0ramfobv1CKoUTWgjm5qfW2CV8=;
        b=fMYZ61/Atk1hYN76/EA2AqGBDsd5OvpmUwm9ulSFBnxYHjl5cciQ933TDVGUbqjRTE
         dHfHsdPmiWS35YdRb/euL7KIuaGiY2BhshS/QiVYsrhcmOZVPAKaUHlCjMQAC8/h9h1M
         8cT0CGTHfdrlGKC3Y4FrvpjX2VEuQ1E68Gm5V/fH+5lDu5Mhc6dZRDbVTpuwR9qNKxfB
         bMlowimlBWvKixpplyacy+EASh0Ewq4drA4AbnQDBBGjm4vt5uEKWYin6tP+lkJq3i8V
         vXhxxwD+kwqR4HAL1uUEwVSNBHCCMEeTXshoeFseaWToor8fk4GLKd8BW0wiLWM652lt
         L+WA==
X-Gm-Message-State: ANhLgQ3wr/SBF8/P+V3BOj+U35d9Jt4novJQlmJDZ7JxvJ6Un7YXwj3G
        6Egz+IxMljdzZfHMbqsuG7uFUq4bInGiYnK/sr9R
X-Google-Smtp-Source: ADFU+vtjoB1L41gbvG3IfZm3ksBmDTvbqLdnYvpmD27Ya9UPhKm77W68IFm4/AxRz3i7hA2sUofnKwQPP6SAVhHtg78=
X-Received: by 2002:a05:6402:8c3:: with SMTP id d3mr5966134edz.31.1584565297053;
 Wed, 18 Mar 2020 14:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1577736799.git.rgb@redhat.com> <20200204231454.oxa7pyvuxbj466fj@madcap2.tricolour.ca>
 <CAHC9VhQquokw+7UOU=G0SsD35UdgmfysVKCGCE87JVaoTkbisg@mail.gmail.com>
 <3142237.YMNxv0uec1@x2> <CAHC9VhTiCHQbp2SwK0Xb1QgpUZxOQ26JKKPsVGT0ZvMqx28oPQ@mail.gmail.com>
 <20200312202733.7kli64zsnqc4mrd2@madcap2.tricolour.ca> <CAHC9VhS9DtxJ4gvOfMRnzoo6ccGJVKL+uZYe6qqH+SPqD8r01Q@mail.gmail.com>
 <20200313192306.wxey3wn2h4htpccm@madcap2.tricolour.ca>
In-Reply-To: <20200313192306.wxey3wn2h4htpccm@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 18 Mar 2020 17:01:26 -0400
Message-ID: <CAHC9VhQKOpVWxDg-tWuCWV22QRu8P_NpFKme==0Ot1RQKa_DWA@mail.gmail.com>
Subject: Re: [PATCH ghak90 V8 07/16] audit: add contid support for signalling
 the audit daemon
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com,
        nhorman@tuxdriver.com, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, dhowells@redhat.com,
        netfilter-devel@vger.kernel.org, ebiederm@xmission.com,
        simo@redhat.com, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        mpatel@redhat.com, Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 13, 2020 at 3:23 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-03-13 12:42, Paul Moore wrote:

...

> > The thread has had a lot of starts/stops, so I may be repeating a
> > previous suggestion, but one idea would be to still emit a "death
> > record" when the final task in the audit container ID does die, but
> > block the particular audit container ID from reuse until it the
> > SIGNAL2 info has been reported.  This gives us the timely ACID death
> > notification while still preventing confusion and ambiguity caused by
> > potentially reusing the ACID before the SIGNAL2 record has been sent;
> > there is a small nit about the ACID being present in the SIGNAL2
> > *after* its death, but I think that can be easily explained and
> > understood by admins.
>
> Thinking quickly about possible technical solutions to this, maybe it
> makes sense to have two counters on a contobj so that we know when the
> last process in that container exits and can issue the death
> certificate, but we still block reuse of it until all further references
> to it have been resolved.  This will likely also make it possible to
> report the full contid chain in SIGNAL2 records.  This will eliminate
> some of the issues we are discussing with regards to passing a contobj
> vs a contid to the audit_log_contid function, but won't eliminate them
> all because there are still some contids that won't have an object
> associated with them to make it impossible to look them up in the
> contobj lists.

I'm not sure you need a full second counter, I imagine a simple flag
would be okay.  I think you just something to indicate that this ACID
object is marked as "dead" but it still being held for sanity reasons
and should not be reused.

-- 
paul moore
www.paul-moore.com
