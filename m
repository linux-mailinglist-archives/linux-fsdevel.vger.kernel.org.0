Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9BB37CA7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 20:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbfFFSvK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 14:51:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41421 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729834AbfFFSvE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 14:51:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id q17so2046192pfq.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2019 11:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vyH/zzUIJOyZ406UEvU+R6XaFldSrQouo2bVvFNJxzs=;
        b=VRyzhkBvBnfDIRuAExLdUvUe//j+40drJjj5Y4J6jfg2b+zgc/ZF0D5KFfqRdmb9XD
         oIvlhoh3t2680hBGfxcTbgJ/LC8Wr/ol8CdMBUxJ5RpEAOGZwG2GFiP0+p5xG0mNgh1m
         wuc2LhZLUHtXEHnqETKLHsM3LVaoGY50Z1gUSqOai2oXB0QiPNuSQS2jc2pO5bHzklX4
         /p5W6YWdAB1I8YBndGyzJXHLf71B4+EiFKXGoQQDwpUedInYUuC+KGw9Nn8uEd74WlDg
         RnlUv/cFUeDYzPoHZWFOImPY8quUPG/mlJPTNX9mhh9YYjv6KHEYb5cL3sPqeoh8xbNB
         YocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vyH/zzUIJOyZ406UEvU+R6XaFldSrQouo2bVvFNJxzs=;
        b=p+BG8QjmddVpVOBV4mnxbtbdEP9w8iD6RaXWPrESsWtGkzQw1TRBqw9DNt6PbDz2rC
         +YaVRA04rCcLioD9mRWmpZBCeAvdWoAbIroX6wt4AXRbqVxoFseBkDYNLVhiKpriIrgw
         G9RQP5aExBJM8ZQL+RvTepTAOZwu4TpaB1Kj71yObrU1YFG2D9v2lOVQf7V6Iy6dwnnf
         NW0BdYM5sfnpzI0wV/BS/G2oxVczMelO0JoFf3Vym14DKtV+ZovsUHCf8SGv2pYB/D9T
         vHuMxbRZu7rzu9gstqbINhVhr+8yEPdaMQy00ahF1a0CVdC3+VgYNpNVYQ1CTevuVf9t
         v+6Q==
X-Gm-Message-State: APjAAAXet+P6OQvoiI978OcVrP+zgXDwbxqVLhKiTceXz6J8/J4m757a
        dUqOrDNn1TpNvaEbixGalZyAjw==
X-Google-Smtp-Source: APXvYqzmdyohsfaZb8gxQfYI50Yq72TPLfhG8iUfN0sGNNPM5UPGJBQMF/zPBOOprsFqvOgWBnUsuQ==
X-Received: by 2002:a17:90a:2506:: with SMTP id j6mr1307940pje.129.1559847064075;
        Thu, 06 Jun 2019 11:51:04 -0700 (PDT)
Received: from ?IPv6:2600:1010:b02c:95e1:658b:ab88:7a44:1879? ([2600:1010:b02c:95e1:658b:ab88:7a44:1879])
        by smtp.gmail.com with ESMTPSA id a25sm3003410pfn.1.2019.06.06.11.51.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 11:51:03 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC][PATCH 00/10] Mount, FS, Block and Keyrings notifications [ver #3]
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <7afe1a85-bf19-b5b4-fdf3-69d9be475dab@schaufler-ca.com>
Date:   Thu, 6 Jun 2019 11:51:01 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>, raven@themaw.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E7472FA4-886E-4325-87EA-9812D08CC2D3@amacapital.net>
References: <b91710d8-cd2d-6b93-8619-130b9d15983d@tycho.nsa.gov> <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk> <3813.1559827003@warthog.procyon.org.uk> <8382af23-548c-f162-0e82-11e308049735@tycho.nsa.gov> <0eb007c5-b4a0-9384-d915-37b0e5a158bf@schaufler-ca.com> <CALCETrWn_C8oReKXGMXiJDOGoYWMs+jg2DWa5ZipKAceyXkx5w@mail.gmail.com> <7afe1a85-bf19-b5b4-fdf3-69d9be475dab@schaufler-ca.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 6, 2019, at 11:33 AM, Casey Schaufler <casey@schaufler-ca.com> wrot=
e:
>=20
>> On 6/6/2019 10:11 AM, Andy Lutomirski wrote:
>>> On Thu, Jun 6, 2019 at 9:43 AM Casey Schaufler <casey@schaufler-ca.com> w=
rote:
>>> ...
>>> I don't agree. That is, I don't believe it is sufficient.
>>> There is no guarantee that being able to set a watch on an
>>> object implies that every process that can trigger the event
>>> can send it to you.
>>>=20
>>>        Watcher has Smack label W
>>>        Triggerer has Smack label T
>>>        Watched object has Smack label O
>>>=20
>>>        Relevant Smack rules are
>>>=20
>>>        W O rw
>>>        T O rw
>>>=20
>>> The watcher will be able to set the watch,
>>> the triggerer will be able to trigger the event,
>>> but there is nothing that would allow the watcher
>>> to receive the event. This is not a case of watcher
>>> reading the watched object, as the event is delivered
>>> without any action by watcher.
>> I think this is an example of a bogus policy that should not be
>> supported by the kernel.
>=20
> At this point it's pretty hard for me to care much what
> you think. You don't seem to have any insight into the
> implications of the features you're advocating, or their
> potential consequences.
>=20
>=20

Can you try to spell it out, then?  A mostly or fully worked out example mig=
ht help.

As Stephen said, it looks like you are considering cases where there is alre=
ady a full communication channel between two processes, and you=E2=80=99re c=
oncerned that this new mechanism might add a side channel too.  If this is w=
rong, can you explain how?=
