Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA5A537C52
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 20:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbfFFSdi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 14:33:38 -0400
Received: from sonic310-27.consmr.mail.gq1.yahoo.com ([98.137.69.153]:44002
        "EHLO sonic310-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727552AbfFFSdi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 14:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559846016; bh=//Lmm2RswPvHcXzfIS6/2qqspsSA2gk2MDuzhJdNvu0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=d0lCSS61UlLOwhZYJ4nmyj+DHMtObAB7cbe5zjXut/EoDilqcFiKZAf8qlf6ghlDZRRVpfAiqVftfvN34VUu9mjEOMX+WL8xGug7ypj1xEnQdO3MeQfv3Bjs412NCN9n0x/mXyr4uGSoPxabF7Tn5CnDLh6fFuOSEIySlI0BG2d2sjufNKlI2TRN5rFtOjhD126uq+TTlVJ2lCpqWJa8F1v+zNKjj4wq1pltv2MuRalNCsMQnAJ70dh0GqofoMqMUTEzv27X1YtHflECHnv0IGm4bQuGOCqMlbWNBEXhbZkZzArenDRQvsp0Lz5BOvfcMBeIJbI6xItggpApjRKIfg==
X-YMail-OSG: tdMH.8EVM1kZvbncE7bbS_U1wY3adjPY3VJYKWpFgufVJC_M074XZlNLatVVlPy
 hBUcaEEjmzlO0JkiV4IWSofg5F.2z7Mf67mBYpkhj.boE3akBaXg.ObrzZTljKS5xrLoEufAtWfo
 IZUFgbIjxBzsNC3Y3qgJgFom4S8Z0cnZ_YGjqd_uugkW3aQBG0Ao4uY5cqaTsA8ASVyaDxpD2laR
 r3e0jW_bUaWn48ZSS4OkuVmSQvJRruG_ETVdQXkyXEooG_Z6k6uAJGvGDQgzIv5AgJsQ0b0SxzrK
 Ont74XXHXuqeDClQLjJLlb.LYc0GrbB2zXNz3eYOklSvQbNu3z0UaQE.lBhdn7wiwhtOIdpDQ1es
 Km5RDq.PSlbtldVaN.ddLSdRA5hxmJyfs2q05l5.SrZQK1YNQhTg_NAsXstGL9BBeSnofdudXhXN
 zz6vmLuk3GdTzRCfXbaY1.dSGYUnCbg2mvD4WECq5cMc1BHdmdFD0LO4h5s7uDCM_5qHhBeqr8on
 if5YPOiUs8Tw.6LrjCS0f48XyI2oV.nvNUY4NtVDXWQjwAwhqAWN9bEUS6zzwleTygSz8U1jzZvT
 R.at2SkpcvM7.tiZtdT1MOoS0BESaiikiVSiwpcneEwChy9bPJ.W7KbZ07W8fhBLGQh11ji2rcSj
 1lO42bdDa5nyRmyzRiJcJgShhCATND5Y9qQcI09ZUYHFfi4eRJhPUGx4iHTimisNdBmx9qMTmWAY
 IJ7y__b.dpzsZv2gEZjPqm3C7UmBRzXPNFLHkOMdWQczscOLGzAcaWR3qgJ73CMEFMUCK80v1pEg
 LeTPm9T6064jbgoUfEhwa6xO7W.8fTbIIq_WOmQXSoGjLA6WLHdtUyZvgisNe1DcaTD5Io3cFZrA
 r9WjJM_2Enwr94Sn130fb0K3CGp3kxjee0D_bL7sZe5SeabKjshY8Oi0NsHyU7rnunHLjRvuYvzl
 jscl5MPU7G287NAWbPgPvJEu5VA8cguO0TTcXzYQsmU6RuitJslrcfhtz.f0WABcOKA0UrwE36f3
 EgJDeAECkvX7sGSbuS8IDTLcN5voceVECP_fROjh4pw6ojD5CZnunHEPzHIea3W32dcrZMGf.GXq
 hqhF2McaU9lfkFsbLbFrNh03yvmeEusyBW6Pe.LAkqEr0D89T0uuo5fK1dLDignM1jDsP7ig6u9M
 vl9Zvv0DTVKMR_xIqhPl1WEc0zc6IVs.fTIXPSEG9j3WG_i6jqlVuvUssS9A52Ihx3gwaGEfAiQT
 COw_Yo6dNcm93.e6RHgOsAbcHlOS_BQY8oP0f1g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Thu, 6 Jun 2019 18:33:36 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp419.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d0231c58126abcca9733f86c1ec00ae8;
          Thu, 06 Jun 2019 18:33:36 +0000 (UTC)
Subject: Re: [RFC][PATCH 00/10] Mount, FS, Block and Keyrings notifications
 [ver #3]
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>, raven@themaw.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>, casey@schaufler-ca.com
References: <b91710d8-cd2d-6b93-8619-130b9d15983d@tycho.nsa.gov>
 <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk>
 <3813.1559827003@warthog.procyon.org.uk>
 <8382af23-548c-f162-0e82-11e308049735@tycho.nsa.gov>
 <0eb007c5-b4a0-9384-d915-37b0e5a158bf@schaufler-ca.com>
 <CALCETrWn_C8oReKXGMXiJDOGoYWMs+jg2DWa5ZipKAceyXkx5w@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <7afe1a85-bf19-b5b4-fdf3-69d9be475dab@schaufler-ca.com>
Date:   Thu, 6 Jun 2019 11:33:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWn_C8oReKXGMXiJDOGoYWMs+jg2DWa5ZipKAceyXkx5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/6/2019 10:11 AM, Andy Lutomirski wrote:
> On Thu, Jun 6, 2019 at 9:43 AM Casey Schaufler <casey@schaufler-ca.com>=
 wrote:
>> ...
>> I don't agree. That is, I don't believe it is sufficient.
>> There is no guarantee that being able to set a watch on an
>> object implies that every process that can trigger the event
>> can send it to you.
>>
>>         Watcher has Smack label W
>>         Triggerer has Smack label T
>>         Watched object has Smack label O
>>
>>         Relevant Smack rules are
>>
>>         W O rw
>>         T O rw
>>
>> The watcher will be able to set the watch,
>> the triggerer will be able to trigger the event,
>> but there is nothing that would allow the watcher
>> to receive the event. This is not a case of watcher
>> reading the watched object, as the event is delivered
>> without any action by watcher.
> I think this is an example of a bogus policy that should not be
> supported by the kernel.

At this point it's pretty hard for me to care much what
you think. You don't seem to have any insight into the
implications of the features you're advocating, or their
potential consequences.


