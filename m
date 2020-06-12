Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4B61F7D47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 21:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgFLTAe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 15:00:34 -0400
Received: from mout.web.de ([212.227.17.12]:42779 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgFLTAc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591988425;
        bh=WSvz5iR9hp1Prq3Qr+9+rmXYQSibTT4zi0zEBk9MRw8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=coedfnGz2HS6Ucd60bUzLqBoROH/x4hqhKq1EbucltTJFML9+uXNWNnD1bntvsvy0
         sYZV/oM9ZUE7TUV1wuouKztmRnBX7i/jae0tjF663mlGvj2PgmM4FR7dpHEbgCpl6f
         EugGsx4BwC6z3KN3dFSFGto78rjelDZxx3WmxBI4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.95.40]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTfol-1jMQTs2Mo9-00U0CQ; Fri, 12
 Jun 2020 21:00:25 +0200
Subject: Re: [v2] proc/fd: Remove unnecessary variable initialisations in
 seq_show()
To:     Matthew Wilcox <willy@infradead.org>,
        Kaitao Cheng <pilgrimtao@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Muchun Song <songmuchun@bytedance.com>
References: <20200612160946.21187-1-pilgrimtao@gmail.com>
 <7fdada40-370d-37b3-3aab-bfbedaa1804f@web.de>
 <20200612170033.GF8681@bombadil.infradead.org>
 <80794080-138f-d015-39df-36832e9ab5d4@web.de>
 <20200612170431.GG8681@bombadil.infradead.org>
 <cd8f10b2-ffbd-e10f-4921-82d75d1760f4@web.de>
 <20200612182811.GH8681@bombadil.infradead.org>
 <d3d13ca7-754d-cf52-8f2c-9b82b8cc301f@web.de>
 <20200612184701.GI8681@bombadil.infradead.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d01e5cb7-c812-746d-667c-06cca202bdcf@web.de>
Date:   Fri, 12 Jun 2020 21:00:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200612184701.GI8681@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GMNHRY8OVbovmdEwZ8cY8IZYdhyo3yrFrxX2P5Pr/8j/e82L4Uj
 EY0bjNZ5jJRdMWZimmE6RrFMAy7e6Ku8nVOQrgMYsn1Erf0n7TFmmlgkeoQDiFzTuZUTmQz
 u6mBN+tcFCoBRtoR36lMEDuJYUdT7kX8CosHN+wLfyAsJbh9vsrVbZoFFWovCOwsBysMDrb
 tlVgIrcddZaFNQnbZYp/g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AJJOby13OXw=:WVqs47nSbxzZdGjoktkwiL
 wsbt8D2EgLvB7E5AzOVk8/VdNV9o9Klnwi3V1u2VNA+8Z2s5gA+aJ5x/0lsFGfrKM5XizvGlT
 pUr2W05aBl6ToTliZCskjcGfdX8kdIZvTYp5HBL85R/AD5UoAo18tTRHQPdLTv91eDqi7bMOb
 1ijwzs661OLekSSqPXuVEkAUE3ya1YKSnuQ5kDW4ofz/byn4GDUJkrtl0hgKtvsSQ4D430w9L
 umB9b8JvRxgGxT/qYk1uoMQKMFKhKjv2Jm3LuC5iX6WWxxdu7YA6M+66HKuR7VSzKdtaAk/b8
 8Jf4wDyln1r8w9MTk648+kqjJt86wXm/D+KtFQ1+8RnogrKCe07H8CPUo+GFnsEpyhGTNnPB6
 KhoZGJsf5hCIgCN9HxsAXLiw0b7eR02cutInCma4LWhgbj2+dHRx4Q8RcMDVSAm6oNydjVCqu
 O4eOHyUFpeyJuKdKvOTlMIOHP2PTB5PTFMLFd9AOD4Arf1ScsnsUxlP7fUUym3ziCbGiRlf4w
 YR6V8OpsxT+NCtu2Yaak9RHvOPlIrsHAPPhYi3DL/GrSYaw5zXGRm/u8ONUlOc5XexVzYCJIw
 jR4qe7505+vCTCYln9vTv8frNn2R+UUi707m31d40zZ8mz9NdIcCFrn93glpLia+NuFyt8J48
 AMU5+1+VT1MXWqnpAPIgRzx1SSKsWNqZf3pWJi71s0TLHFz287W++hz37pJGMC6gXIk8N1wqi
 /5MyeUWOcFAeqKYFvttSbg3qjTOQuQpMUyOHfHQkC2FGskZErpcG7+OCydta8DLrYMP3l+JEp
 hyna8oFesgNN8bRFZ1Gp2bjPzSi1DoKMo4Kp3IjtdZFdRoBgIZ/osn9X7YMrz6QOnB7VFTUqY
 vLLcYPt5mERESpEtZYbOkxp32/JcPUvpY0+SJSDp/IbZgpQAEyIpQCDQkgoBHHGtRLpXpqgm7
 Yk6ZdmvtyBo0HiPqfAVLpEU0sDMuwJpTniurRx7u6v29sLxzhZcjrpi+bYtaO5+r4lhS/nJmD
 rLoeHe5RHosFdVTHxqYYffctIitjnrxZIzCkB1BDcgXFO7uI3Qzn2AhR6r+TJUpGtC4ujmV34
 HnBCFcSLItu9/yzU1ADH+tHH8SZCY/Ghd6l19sNZ/R123JTnLl35pnI/Nb5acLs8C8GHl3OlZ
 AoMOZEJ/DRhlIT534X5hZtarsSct1ofTKOZJBivat/djx4q27ha2TzIYsIHtYuh6oYoCv0ThN
 U44iXQg8/SWsmdpRA
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> I suggest to take another look at published software development activi=
ties.
>
> Do you collateral evolution in the twenty?

Evolutions and software refactorings are just happening.
Can we continue to clarify the concrete programming items
also for a more constructive review of this patch variant?

Regards,
Markus
