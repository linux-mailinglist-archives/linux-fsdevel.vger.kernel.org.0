Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE73417D57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 23:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344070AbhIXV5k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 17:57:40 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:40683
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343996AbhIXV5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 17:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632520565; bh=DwLdTaIH5wbh33gGt4zSu0dsn+5fXtM8/mYtHBpFI4I=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=De2h6BVpadV/IGeUY9FLtxYAv5fILRgoPUGxbK0sQunVnKo6YWCE5R8rD+xAlmyu9eVXMaeAp1vzX8J7HaAjza9h/ucNiwYhCxooNYxwLZ5yUcBAEvBMTxT4mmO2Ht5xByx8YQ7BKesTk7+E3drpX/r4EaUFNwbTeqFt/UORBYBm9yDf2MUsqzbUEybLvre5vj2LETCV9/HItTgxObULdG6s+/dDym4mfjgGZaDAbo7t1jH4MqW/wJDrGCzQ/t2pyFDdKO/s5mQXOH71e56PPESVaQcJVfbF9OFTkokbTohRt41el3KCkXFHVN7zjhkB4433+v3l23UCBPASjAbs5g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632520565; bh=flS14tf5y8g7PkwnbIJ+345lgyKr/KGHEem/cuqabrQ=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=ZAo0B7AlTBi1gt3CqD0ilGjus5JJzxd26V3dCGnxf1Ncr7jT+b+CbkwriwBdUURAitWVnlO/GIMAnegJUDCu/MdBMzCS+56zUz6UQpE5DgntNBYb+iOkYjQ5TTHMVv6s17NWEh8eMAIrpRQGEYUAoPo3NTwCi0nzryADGa1hl0Ga+QbElerOipd6iYfUdFDKTv4JP3XaTVuNOxCZ6lT7M/4fvfKTA58hi7BFxA3PNTracLqblF0Ks3t8LdjuN5Hqu1CADl24c55/HiAJ5JPj6CE9HJKsRSfQsqjd1v2W52Sw+r25mp83wFdnc/TEh+/S/iCkVeYmk/j9ZfKBQplUhQ==
X-YMail-OSG: uJZs7tMVM1nFN9mNYssaDnlC4ro_pVzSYJPFXFGBMHh50jT_xZPvUb1e_FV.bl.
 kP.7lTqp1UWMJIp1r5MSMGWi0LCLV89vY_v1ucn7kpA0aMEE7nOfsJH_BSGWH67Voc98s8AJP6y3
 Bhf.CoHYs84xvq.tVHdqdyH1QSdhTQc6_OIUufvL7bHDmMBvLxvWv5OKe6O_w0H4PyuuQJv.XZ4t
 k6wbbixR5oIDymB09aCIhINJu9jJQOFWUJ7_6MmLl2UqUj1GovwJhWSN9zl2cRNhPOJnyUn5Idud
 zhP7.cIXDdK6OoZWaLBwPY2HGgV1gXeQ22HliiNiYjcehobLIMKMT_1vms6N6S4lEupRqsxY5JjI
 hBlEtLzMXFPuxtKXX58uBZ7nKY0CYmNe.r14ofuePfCzMFgOzk.x6CCCrbFhs4yM3ZQPML8Ig173
 exgG5rjJGAsJXcg56dQ_tBniBD6tdTow44cpaPRq4_7RjY.myGHeJGvpO5kEjPVqt5CcVH0uhCsy
 ms0LYTI7H97Kk8.jLeZzOpAg8sRpGTNUQvqHH1LqLP3p3I0GoJtkZdXPmLaJlD7wQL_Js9.QtL9T
 2VhhzdEpvqt05EOOo_mgEz_j4MRmQ1e0ZCUawccxIWjJTtkN7.BMMJmnFHPd23B_tBj0aWi8YVPd
 rl7PPxALD0bilQAl.CpBdFZZHgvW3.KEwOyl2mPtEoRT8boUKDla5xyWGKPZcUWuVLWz9K7brptY
 GSUR71OxGKSte3eh2YRlVTAZkUynlRDoNuznVljvHG1qnq3sRe8hot7ofYkrYO8Vmy7Y.rtb4fPf
 _4x4EaIGlNNlbQgw2FFO6Bcglfdu8D8uBKosfsSG7ifam9OfvX0FR6o8fJUEPG40_tjKW8h1mZYE
 qgrqZPbmNHYH5rg50KErL3LZ9n6oKTdg7LOTDqypHVr368Dnbo3sPH5ps7DWlrfd2i1x.rDR5E9i
 Nx3ReERbxoHU23JqpHyydBZrb_04re6o2Yac8LhM7sy8xZjtUN2lGOv7yfXPyiZJOVIX5RaRvMsx
 LNTyhkKAxdwYlqhg4v7XLL3dRcZatoHELgzefbb36cAmp.oQVMYXcVe94fEfks.aGIiYNA1LxReX
 4OVnxU8ZovKHO6tUztwhu7WmMXT737XV1pOoJFtdGrolPbHrwQFq6DtFCEM_sTTa3QTzLypNSX7h
 yqNiACOgGbLqxlLGh6Gt_0tLRE4SMmvBmVvwUsIEZHYExokx0KM53QLBNsc8v5j2sHLX.W94Htwh
 yYD7k9ohApDAMS.Xrha1_qyF.MS5rfjE4FxVxeBVu5wa7QCJbgLSc3fk2iovRpLnpwY_J60cHMuK
 TPClW_jnnkHXk4MNDvXL3QO9kffIY9AHsROvEGqDOlYBa25WlMv5Rxwnhl0CzG_LvO2_weMBbG.u
 .zS8Crqkx5tUM8mfQWR0nlieMyL0lNiKk.N8KlSkSmt309h6TDkxtP9pGXVO5Wf9L66_1bK0iUrt
 JVRpvtdhyRW7FqVFgNdyCpLf80ZSn7czH86Y0Cisg6wHbEDBProEotT4hV9.gytWLrmJ41XFobNZ
 8GSQ_nsZPe_LJCtJEF.tJxbk7FC5sBbfAIXYDHSnAEnyhVK4WSKZdfB8IamlgCl2FIuQBkloCyko
 zEDo0lpHyxvNFkqMHp3y7fEXArR7vq7pYr8ZgFnTfHBoL_mj_Bptj8jvNbJNAk5hXOACh8rniuNY
 JY_yDeBAIVhGTgjcg2PutvChC6mveD2IqT8gAzALOl1XJxKeCGgDhbdZ.y5UVmcpZbR0WpkwDXuB
 i.oFcBNB2z9Gw0reyiOIP3GRk641PhKyu7tI4q7ErhYlFqUL_sjlVjOOHw05ywJLtbbDyHqToauW
 Db0jTALrk4V64KGx.W_nEFBTH_KKaTbWtfK3RBreh0M2hblTChf2SC32paXQWufiYoLM7ATOMmzb
 gV0GIFY3MToofBj4Xp6HFG_6EsKh58EHMIVto_GeI7pFNc.pep8c9g4a7iZeDk7XCcaQT4mghz7u
 pJxDlQU9JKuAJG496oD2Mo5ldMltSZ9aIOC08ufyO0WeIdyTUNzRI0AuAIb5HWntbW8adbz2OU2_
 ON81GThX_ICllnHl9kshewQTuGXU721NlmIXAJfyutASVyDK6Xnz3rWWCcQDo7KYZOuTPk9L7DKF
 vmohVjtsSFakty0pQFoWMvvYQizI_ePiYdpYg.jb85rmH_JwtyMMQvVFMhwmkZi_PgCzniKnlHWY
 WJUMkp0ItdPrOFpxtzOCsqUtoCz.IfzwBaVoqRqDbKIQB8ENNN9gSFf77_ZY5H5RA2k_pnD2AQD_
 UaPOxg7Pfq1wS44bq5VERDGha9y9sKtiwaG5Q9I5w81CzXjpwIWcN_D4SRV4yjHI-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Sep 2021 21:56:05 +0000
Received: by kubenode516.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID affb7af1e33c09fecf33092be9d6380a;
          Fri, 24 Sep 2021 21:56:00 +0000 (UTC)
Subject: Re: [PATCH 2/2] fuse: Send security context of inode on file creation
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        chirantan@chromium.org, miklos@szeredi.hu,
        stephen.smalley.work@gmail.com, dwalsh@redhat.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210924192442.916927-1-vgoyal@redhat.com>
 <20210924192442.916927-3-vgoyal@redhat.com>
 <a843a6d9-2e7a-768c-b742-fc190880b439@schaufler-ca.com>
 <YU4ypwtADWRn/A0p@redhat.com>
 <f92a082e-c329-f079-6765-ac8b44e45ee4@schaufler-ca.com>
 <YU5AQB/owpnC/yeZ@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <58812eb0-6ced-64bc-4d08-c82eca2bae11@schaufler-ca.com>
Date:   Fri, 24 Sep 2021 14:55:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YU5AQB/owpnC/yeZ@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.19043 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/24/2021 2:16 PM, Vivek Goyal wrote:
> On Fri, Sep 24, 2021 at 01:54:20PM -0700, Casey Schaufler wrote:
>> On 9/24/2021 1:18 PM, Vivek Goyal wrote:
>>> On Fri, Sep 24, 2021 at 12:58:28PM -0700, Casey Schaufler wrote:
>>>> On 9/24/2021 12:24 PM, Vivek Goyal wrote:
>>>>> When a new inode is created, send its security context to server al=
ong
>>>>> with creation request (FUSE_CREAT, FUSE_MKNOD, FUSE_MKDIR and FUSE_=
SYMLINK).
>>>>> This gives server an opportunity to create new file and set securit=
y
>>>>> context (possibly atomically). In all the configurations it might n=
ot
>>>>> be possible to set context atomically.
>>>>>
>>>>> Like nfs and ceph, use security_dentry_init_security() to dermine s=
ecurity
>>>>> context of inode and send it with create, mkdir, mknod, and symlink=
 requests.
>>>>>
>>>>> Following is the information sent to server.
>>>>>
>>>>> - struct fuse_secctx.
>>>>>   This contains total size of security context which follows this s=
tructure.
>>>>>
>>>>> - xattr name string.
>>>>>   This string represents name of xattr which should be used while s=
etting
>>>>>   security context. As of now it is hardcoded to "security.selinux"=
=2E
>>>> Why? It's not like "security.SMACK64' is a secret.
>>> Sorry, I don't understand what's the concern. Can you elaborate a bit=

>>> more.
>> Sure. Interfaces that are designed as special case solutions for
>> SELinux tend to make my life miserable as the Smack maintainer and
>> for the efforts to complete LSM stacking. You make the change for
>> SELinux and leave the generalization as an exercise for some poor
>> sod like me to deal with later.
> I am not expecting you do to fuse work. Once you add the new security
> hook which can return multiple labels, I will gladly do fuse work
> to send multiple labels.
>
>>> I am hardcoding name to "security.selinux" because as of now only
>>> SELinux implements this hook.
>> Yes. A Smack hook implementation is on the todo list. If you hard code=

>> this in fuse you're adding another thing that has to be done for
>> Smack support.
>>
>>>  And there is no way to know the name
>>> of xattr, so I have had to hardcode it. But tomorrow if interface
>>> changes so that name of xattr is also returned, we can easily get
>>> rid of hardcoding.
>> So why not make the interface do that now?
> Because its unnecessary complexity for me. When multiple label support
> is not even there, I need to write and test code to support multiple
> labels when support is not even there.

Subsystems that treat labels as a special case (as opposed to supporting =
xattrs
properly) make me sad.


>>> If another LSM decides to implement this hook, then we can send
>>> that name as well. Say "security.SMACK64".
>> Again, why not make it work that way now, and avoid having
>> to change the protocol later? Changing protocols and interfaces
>> is much harder than doing them generally in the first place.
> In case of fuse, it is not that complicated to change protocol and
> add new options. Once you add support for smack and multiple labels,
> I will gladly change fuse to be able to accomodate that.

Cool. I'll hold you to that. Priority has been bumped up.



>>>>> - security context.
>>>>>   This is the actual security context whose size is specified in fu=
se_secctx
>>>>>   struct.
>>>> The possibility of multiple security contexts on a file is real
>>>> in the not too distant future. Also, a file can have multiple releva=
nt
>>>> security attributes at creation. Smack, for example, may assign a
>>>> security.SMACK64 and a security.SMACK64TRANSMUTE attribute. Your
>>>> interface cannot support either of these cases.
>>> Right. As of now it does not support capability to support multiple
>>> security context. But we should be easily able to extend the protocol=

>>> whenever that supports lands in kernel.
>> No. Extending single data item protocols to support multiple
>> data items *hurts* most of the time. If it wasn't so much more
>> complicated you'd be doing it up front without fussing about it.
> Its unnecessary work at this point of time. Once multiple labels
> are supported, I can do this work.
>
> I think we will need to send extra structure which tells how many
> labels are going to follow. And then all the labels will follow
> with same format I am using for single label.
>
> struct fuse_secctx; xattr name string; actual label
>
>>>  Say a new option
>>> FUSE_SECURITY_CTX_EXT which will allow sending multiple security
>>> context labels (along with associated xattr names).
>>>
>>> As of now there is no need to increase the complexity of current
>>> implementation both in fuse as well as virtiofsd when kernel
>>> does not even support multiple lables using security_dentry_init_secu=
rity()
>>> hook.
>> You're 100% correct. For your purpose today there's no reason to
>> do anything else. It would be really handy if I didn't have yet
>> another thing that I don't have the time to rewrite.
> I can help with adding fuse support once smack supports it. Right now
> I can't even test it even if I sign up for extra complexity.
>
> Vivek
>

